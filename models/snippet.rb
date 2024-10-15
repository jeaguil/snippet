require 'active_record'

#
# The Snippet class represents a code snippet with a title and content.
# It includes validations to ensure that both the title and content are present.
#
# Attributes:
# - title: The title of the snippet (String).
# - content: The content of the snippet (String).
# - tags: A comma-separated list of tags associated with the snippet (String).
#
# Methods:
# - tags: Returns the tags attribute or an empty string if not set.
# - tag_list: Splits the tags attribute into an array of individual tags.
#
# Example:
#   snippet = Snippet.new(title: "Example", content: "This is an example snippet.")
#   snippet.tags = "ruby, rails, code"
#   snippet.tag_list # => ["ruby", "rails", "code"]
class Snippet < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true

  def tags
    read_attribute(:tags) || ''
  end

  def tag_list
    tags.split(', ').map(&:strip)
  end
end