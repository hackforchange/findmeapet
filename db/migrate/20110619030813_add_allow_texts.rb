class AddAllowTexts < ActiveRecord::Migration
  def self.up
    add_column :people, :allow_texts, :boolean, :default => true
  end

  def self.down
    remove_column :people, :allow_texts
  end
end
