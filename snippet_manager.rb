require_relative 'cli/snippet_cli'

# Check to see if the database exists, and if not, create it
if !File.exist?('db/snippets.db')
  system("ruby db/migrate/01_create_snippets.rb")
end

# Start the CLI
SnippetCLI.start(ARGV)