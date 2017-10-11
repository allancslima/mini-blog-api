class RenameContentToBodyInComments < ActiveRecord::Migration[5.1]
  def change
  	rename_column :comments, :content, :body
  end
end