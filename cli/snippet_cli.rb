require 'thor'

require_relative '../models/snippet'
require_relative '../config/database'

#
# SnippetCLI is a command-line interface for managing code snippets.
# It provides commands to add, list, search, and show code snippets.
#
# Commands:
# - add TITLE CONTENT --tags TAGS --language LANGUAGE: Add a new code snippet
#   - TITLE: The title of the snippet
#   - CONTENT: The content of the snippet
#   - --tags: Optional tags for the snippet
#   - --language: Optional language of the snippet
#
# - list: List all code snippets
#
# - search KEYWORD: Search for code snippets by keyword in title or tags
#   - KEYWORD: The keyword to search for
#
# - show ID: Show details for a specific code snippet
#   - ID: The ID of the snippet to show
class SnippetCLI < Thor
  desc "add TITLE CONTENT --tags TAGS --language LANGUAGE", "Add a new code snippet"
  option :tags, type: :string, required: false
  option :language, type: :string, required: false
  def add(title, content)
    snippet = Snippet.new(
      title: title,
      content: content,
      tags: options[:tags] || "",
      language: options[:language] || "unknown")
    
    if snippet.save
      puts "Snippet '#{title}' added successfully!"
    else
      puts "Error: #{snippet.errors.full_messages.join(', ')}"
    end
  end

  desc "list", "List all code snippets"
  def list
    snippets = Snippet.all
    snippets.each do |snippet|
      puts "##{snippet.id} #{snippet.title} (#{snippet.language})"
      puts snippet.content
      puts "Tags: #{snippet.tag_list.join(', ')}"
      puts
    end
  end

  desc "search KEYWORD", "Search for code snippets by keyword in title or tags"
  def search(keyword)
    snippets = Snippet.where("title LIKE ? OR tags LIKE ?", "%#{keyword}%", "%#{keyword}%")
    snippets.each do |snippet|
      puts "##{snippet.id} #{snippet.title} (#{snippet.language})"
      puts snippet.content
      puts "Tags: #{snippet.tag_list.join(', ')}"
      puts
    end
  end

  desc "show ID", "Show details for a specific code snippet"
  def show(id)
    snippet = Snippet.find_by(id: id)
    if snippet
      puts "##{snippet.id} #{snippet.title} (#{snippet.language})"
      puts snippet.content
      puts "Tags: #{snippet.tag_list.join(', ')}"
    else
      puts "Error: Snippet with ID #{id} not found"
    end
  end
end