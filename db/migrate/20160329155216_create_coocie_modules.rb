class CreateCoocieModules < ActiveRecord::Migration
  def change
    create_table :coocie_modules do |t|

      t.string :body
      t.timestamps
    end
  end
end
