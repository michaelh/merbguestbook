class EntryMigration < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.string      :author 
      t.string      :email 
      t.text        :text 
      t.boolean     :show, :default => false 

      t.timestamps
    end 
  end

  def self.down
    drop_table :entries
  end
end
