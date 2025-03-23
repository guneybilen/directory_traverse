class SayController < ApplicationController
  def hello
    @time = Time.now
  end

  def goodbye
  end

  def directories
    # @files = Dir.glob("**/*").reject { |path| path.start_with?("tmp/") || path == "tmp" }
    @file_tree = build_tree(".")
  end

  def build_tree(path)
    tree = {}
    Dir.foreach(path) do |entry|
      next if entry == "." || entry == ".." || entry == ".git" || entry.start_with?("tmp")

      full_path = File.join(path, entry)
      if File.directory?(full_path)
        tree[entry] = build_tree(full_path) # Recursively build subdirectory.
      else
        tree[entry] = nil # Files are leaf nodes.
      end
    end
    tree
  end
end
