require 'spec_helper'
require 'thor'
require_relative '../../cli/snippet_cli'
require_relative '../../models/snippet'
require_relative '../../config/database'

RSpec.describe SnippetCLI, type: :cli do
  context 'add' do
    it 'adds a snippet successfully' do
      output = capture(:stdout) { SnippetCLI.start(['add', 'Test Snippet', 'This is a test snippet', '--tags', 'test,example', '--language', 'ruby']) }

      expect(output.strip).to include("Snippet 'Test Snippet' added successfully!")
      snippet = Snippet.find_by(title: "Test Snippet")
      expect(snippet).not_to be_nil
      expect(snippet.content).to eq("This is a test snippet")
      expect(snippet.tags).to eq("test,example")
      expect(snippet.language).to eq("ruby")
    end
  end

  context 'list' do
    it 'lists all snippets' do
      Snippet.create(title: "Snippet 1", content: "Content 1", tags: "tag1", language: "ruby")
      Snippet.create(title: "Snippet 2", content: "Content 2", tags: "tag2", language: "python")

      output = capture(:stdout) { SnippetCLI.start(['list']) }

      # normalize newlines to make the output consistent
      normalized_output = output.gsub(/\r\n?/, "\n").strip

      expect(normalized_output).to include("Snippet 1")
      expect(normalized_output).to include("Tags: tag1")
    end
  end

  context 'show' do
    it 'shows a specific snippet' do
      snippet = Snippet.create(title: "Snippet 1", content: "Content 1", tags: "tag1", language: "ruby")

      output = capture(:stdout) { SnippetCLI.start(['show', snippet.id]) }

      expect(output).to include("#4 Snippet 1 (ruby)")
      expect(output).to include("Content 1")
      expect(output).to include("Tags: tag1")
    end
  end

  context 'search' do
    it 'searches for snippets by keyword' do
      Snippet.create(title: "Search Snippet Test 1", content: "Search Snippet Test Content 1", tags: "tag10", language: "ruby")
      Snippet.create(title: "Search Snippet Test 2", content: "Search Snippet Test Content 2", tags: "tag20", language: "python")

      output = capture(:stdout) { SnippetCLI.start(['search', 'Snippet']) }

      expect(output).to include("Search Snippet Test 1 (ruby)")
      expect(output).to include("Content 1")
      expect(output).to include("Tags: tag10")
      expect(output).to include("Search Snippet Test 2 (python)")
      expect(output).to include("Content 2")
      expect(output).to include("Tags: tag20")
    end
  end
end

# Captures the output of a given stream (e.g., :stdout or :stderr) during the execution of a block.
#
# @param stream [Symbol, String] the stream to capture (:stdout or :stderr)
# @yield the block of code whose output will be captured
# @return [String] the captured output of the stream
#
# @example
#   output = capture(:stdout) do
#     puts "Hello, world!"
#   end
#   puts output # => "Hello, world!\n"
def capture(stream)
  begin
    stream = stream.to_s
    eval "$#{stream} = StringIO.new"
    yield
    result = eval("$#{stream}").string
  ensure
    eval("$#{stream} = #{stream.upcase}")
  end
  result
end