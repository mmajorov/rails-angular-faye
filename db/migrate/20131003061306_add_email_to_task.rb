class AddEmailToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :email, :string
  end
end
