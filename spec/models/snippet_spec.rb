require 'spec_helper'
require_relative '../../models/snippet'
require_relative '../../config/database'

RSpec.describe Snippet, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      # Creates a new Snippet object with the specified title, content, language, and tags.
      # 
      # @param title [String] the title of the snippet
      # @param content [String] the content of the snippet
      # @param language [String] the programming language of the snippet
      # @param tags [String] a comma-separated list of tags associated with the snippet
      # 
      # @return [Snippet] a new Snippet object
      snippet = Snippet.new(title: "Test Snippet", content: "This is a test snippet", language: "ruby", tags: 'ruby,hello')
      expect(snippet).to be_valid
    end

    it 'is not valid without a title' do
      snippet = Snippet.new(content: "This is a test snippet", language: "ruby")
      expect(snippet).not_to be_valid
    end

    it 'is not valid without content' do
      snippet = Snippet.new(title: "Test Snippet", language: "ruby")
      expect(snippet).not_to be_valid
    end

    it 'allows optional tags and language' do
      snippet = Snippet.new(title: "Test Snippet", content: "This is a test snippet")
      expect(snippet).to be_valid
    end
  end
end