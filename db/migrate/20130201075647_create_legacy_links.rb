class CreateLegacyLinks < ActiveRecord::Migration
  def change
    create_table :legacy_links do |t|
      t.string :name
      t.string :slug
      t.string :new_url
    end

    add_index :legacy_links, :slug
  end
end
