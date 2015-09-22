class CreateHerodata < ActiveRecord::Migration
  def change
    create_table :herodata, :primary_key => :name do |t|
      t.string :name
      t.text :value
    end
    Herodata.create(name: "img1", value: "")
    Herodata.create(name: "img2", value: "")
    Herodata.create(name: "img3", value: "")
    Herodata.create(name: "text1", value: "")
    Herodata.create(name: "text2", value: "")
  end
end
