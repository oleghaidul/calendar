class CreateSocialProfiles < ActiveRecord::Migration
  def change
    create_table :social_profiles do |t|
      t.integer :user_id
      t.string :provider
      t.string :uid
      t.string :token

      t.timestamps
    end
  end
end
