class AddMoreToJob < ActiveRecord::Migration[5.0]
  def change
  	add_column :jobs, :contact_phone, :string
  	add_column :jobs, :contact_address, :string

  end
end
