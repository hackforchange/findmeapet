class Shelter < ActiveRecord::Base
  validates_presence_of :title, :latitude, :longitude, :shelter_code
  validates_uniqueness_of :shelter_code, :title

  def shelter_code
    'MIAD'
  end

  def update_dogs
=begin
    doc = Nokogiri::XML(open("http://www.petharbor.com/resultsRSS.asp?searchtype=ADOPT&view=sysadm.v_animal&shelterlist='#{shelter_code}'&atype=dog&where=type_DOG"))
=end

    doc = Nokogiri::HTML(open("http://www.petharbor.com/results.asp?searchtype=ADOPT&start=4&stylesheet=include/default.css&frontdoor=1&friends=1&samaritans=1&nosuccess=0&orderby=Brought%20to%20the%20Shelter&rows=10&imght=120&imgres=thumb&view=sysadm.v_animal&nomax=1&fontface=arial&fontsize=10&miles=200&lat=25.813025&lon=-80.134065&shelterlist=%27MIAD%27&atype=dog&where=type_DOG&PAGE=1"))

    doc.css('table.ResultsTable tr')[1..-1].each do |dog_item|
      tds = dog_item.css('td')
      petharbor_id = tds[1].content[/(.*) \((.*)\)/, 2]
      if Dog.find_by_petharbor_id.blank?
        Dog.create(
            :petharbor_id =>petharbor_id,
            :name => tds[1].content[/(.*) \((.*)\)/, 1],
            :gender => tds[2].content,
            :color => tds[3].content,
            :breed => tds[4].content,
            :age => parse_date_from_td(td[5]),
            :brought_to_shelter_at => parse_date_from_td(tds[6]),
            :shelter_id => 1 # hardcode 1 as Miami Dode shelter for now.. todo: change this!
        )
      end
    end

  end

  def parse_age_from_td(td)
    children = td.children
    years = children[0].content[/(\d*).*/, 1].to_i
    months = children[2].content[/(\d*).*/, 1].to_i
    days = children[4].content[/(\d*).*/, 1].to_i
    years*365+months*30+days
  end

  parse_date_from_td(td)
  Date.strptime(td.content, '%Y.%m.%d')

end