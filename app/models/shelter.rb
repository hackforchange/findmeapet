require 'nokogiri'
require 'open-uri'

class Shelter < ActiveRecord::Base
  #validates_presence_of :title, :latitude, :longitude, :shelter_code
  #validates_uniqueness_of :shelter_code, :title
  has_many :pets

  def image_prefix
    {'MIAD' => "http://www.petharbor.com/"}
  end

  def update_pets_first_page_only
    doc = Nokogiri::HTML(open("http://www.petharbor.com/results.asp?searchtype=ADOPT&start=4&stylesheet=include/default.css&frontdoor=1&friends=1&samaritans=1&nosuccess=0&orderby=Brought%20to%20the%20Shelter&rows=10&imght=120&imgres=thumb&view=sysadm.v_animal&nomax=1&fontface=arial&fontsize=10&miles=200&lat=25.813025&lon=-80.134065&shelterlist=%27#{shelter_code}%27&atype=dog&where=type_DOG&PAGE=1"))

    doc.css('table.ResultsTable tr')[1..-1].each do |pet_item|
      tds = pet_item.css('td')
      petharbor_id = tds[1].content[/(.*) \((.*)\)/, 2]
      create_pet_from_tds(tds) if Pet.find_by_petharbor_id(petharbor_id).blank?
    end

  end

  def create_pet_from_tds(tds)
    Pet.create!(
        :petharbor_id =>tds[1].content[/(.*) \((.*)\)/, 2],
        :name => tds[1].content[/(.*) \((.*)\)/, 1],
        :gender => tds[2].content,
        :color => tds[3].content,
        :breed => tds[4].content,
        :age => parse_age_from_td(tds[5]),
        :brought_to_shelter_at => parse_date_from_td(tds[6]),
        :shelter_id => self.id,
        :image_uri => tds[0].css('img')[0].attribute('src').value
    )
  end

  def update_pets
    doc = Nokogiri::HTML(open(url_for_page(1)))
    total_pages = get_total_pages(doc)
    first = true
    latest_date_brought_into_shelter = nil

    total_pages.downto(1).each do |page|
      doc = Nokogiri::HTML(open(url_for_page page))
      doc.css('table.ResultsTable tr').reverse[0..-2].each do |pet_item|
        tds = pet_item.css('td')
        if first
          latest_date_brought_into_shelter = parse_date_from_td(tds[6])
          first = false
        end
        petharbor_id = tds[1].content[/(.*) \((.*)\)/, 2]
        if Pet.find_by_petharbor_id(petharbor_id).present?
          if latest_date_brought_into_shelter == parse_date_from_td(tds[6])
            next
          else
            return
          end
        else
          create_pet_from_tds(tds)
        end
      end
    end
  end

  def parse_age_from_td(td)
    children = td.children
    if children[2].nil? # hacky error checking (if age is unknown)
      return nil
    end
    years = children[0].content[/(\d*).*/, 1].to_i
    months = children[2].content[/(\d*).*/, 1].to_i
    days = children[4].content[/(\d*).*/, 1].to_i
    years*365+months*30+days
  end

  def parse_date_from_td(td)
    Date.strptime(td.content, '%Y.%m.%d')
  end

  def url_for_page(page)
    "http://www.petharbor.com/results.asp?searchtype=ADOPT&start=4&stylesheet=include/default.css&frontdoor=1&friends=1&samaritans=1&nosuccess=0&orderby=Brought%20to%20the%20Shelter&rows=10&imght=120&imgres=thumb&view=sysadm.v_animal&nomax=1&fontface=arial&fontsize=10&miles=200&lat=25.813025&lon=-80.134065&shelterlist=%27#{shelter_code}%27&atype=dog&where=type_DOG&PAGE=#{page}"
  end

  def get_total_pages(doc)
    doc.css('center')[1].content[/(\d*) of (\d*)/, 2].to_i
  end

end
