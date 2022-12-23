class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.string :user_name
      t.string :user_email
      t.references :event, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
