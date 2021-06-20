class CreateTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :tokens do |t|
      t.belongs_to :user
      
      t.string :band_name
      t.integer :followers
      t.timestamps
    end
  end
end
