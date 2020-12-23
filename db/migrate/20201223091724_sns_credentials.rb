class SnsCredentials < ActiveRecord::Migration[6.0]
  def change
    drop_table :sns_credentials
  end
end
