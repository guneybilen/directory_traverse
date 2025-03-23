class SayController < ApplicationController
  def hello
    @time = Time.now
  end

  def goodbye
  end

  def directories
    # @files = Dir.glob("**/*").reject { |path| path.start_with?("tmp/") || path == "tmp" }
    if params[:path].present?
      path = params[:path]
      if Dir.exist?(path)
        @file_tree = build_tree(path)
        flash.clear if @file_tree.present?
      else
        flash[:error] = "The specified path does not exist: #{path}"
        file_tree= {}
      end
    else
      @file_tree = {}
      flash[:error] =  nil
    end
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
