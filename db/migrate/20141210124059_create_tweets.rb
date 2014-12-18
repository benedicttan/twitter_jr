class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.belongs_to :twitter_user
      t.string :text
      t.string :status
      t.timestamps
    end
  end
end
