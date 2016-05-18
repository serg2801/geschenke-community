class CreateIpAddresses < ActiveRecord::Migration
  def change
    create_table :ip_addresses do |t|

      t.string :ip
      t.boolean :mobile, :default => false

      t.timestamps
    end
  end
end
