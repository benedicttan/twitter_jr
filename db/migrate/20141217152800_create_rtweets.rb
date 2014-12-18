class CreateRtweets < ActiveRecord::Migration
  def change
    create_table :rtweets do |t|
      t.belongs_to :user
      t.string :text
      t.string :status
      t.timestamps
    end
  end
end
