require_relative '../../config/database'

# This migration creates the 'snippets' table with the following columns:
# - title: a string to store the title of the snippet
# - content: a text field to store the content of the snippet
# - language: a string to store the programming language of the snippet
# - tags: a string to store tags associated with the snippet
# - timestamps: two datetime fields, 'created_at' and 'updated_at', which are automatically managed by Rails
class CreateSnippets < ActiveRecord::Migration[6.1]
  def change
    create_table :snippets do |t|
      t.string :title
      t.text :content
      t.string :language
      t.string :tags
      t.timestamps
    end
  end
end

CreateSnippets.new.change