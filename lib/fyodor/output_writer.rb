require "fyodor/md_generator"
require "fyodor/org_generator"

module Fyodor
  class OutputWriter
    def initialize(library, output_dir, config)
      @library = library
      @output_dir = output_dir
      @output_dir.mkdir unless @output_dir.exist?
      @config = config
    end

    def write_all
      puts "\nWriting to #{@output_dir}..." unless @library.empty?
      @library.each do |book|
        # content = MdGenerator.new(book, @config).content
        content = OrgGenerator.new(book, @config).content
        File.open(path(book), "w") { |f| f.puts(content) }
      end
    end


    private

    def path(book)
      ext = "org"  # @todo

      path = @output_dir + "#{book.basename}.#{ext}"

      i = 2
      while(path.exist?) # @todo1 should 'merge' with already present files (?)
        path = @output_dir + "#{book.basename} - #{i}.#{ext}"
        i += 1
      end

      path
    end
  end
end
