require "fyodor/strings"

module Fyodor
  class OrgGenerator
    include Strings

    def initialize(book, config)
      @book = book
      @config = config
    end

    def content
      header + body + bookmarks
    end


    private

    def header
      return <<~EOF
      * #{@book.title}
      #{":PROPERTIES:\n:Author: #{@book.author}\n:END:" unless @book.author.to_s.empty?}
      EOF
      #{header_counts}
    end

    def header_counts
      output = ""
      @book.count_types.each do |type, n|
        output += "#{n} #{pluralize(type, n)}, " if n > 0
      end
      output.delete_suffix(", ")
    end

    def pluralize(type, n)
      n == 1 ? SINGULAR[type] : PLURAL[type]
    end

    def body
      entries = @book.reject { |entry| entry.type == Entry::TYPE[:bookmark] }
      entries.size == 0 ? "" : entries_render(entries)
    end

    def bookmarks
      bookmarks = @book.select { |entry| entry.type == Entry::TYPE[:bookmark] }
      bookmarks.size == 0 ? "" : entries_render(bookmarks, "Bookmarks")
    end

    def entries_render(entries, title=nil)
      output = "\n\n"
      output += "** #{title}\n\n" unless title.nil?
      entries.each do |entry|
        output += "#{item_text(entry)}\n\n"
      end
      output
    end

    def item_text(entry)
      case entry.type
      when Entry::TYPE[:bookmark]
        "*** #{page(entry)}"
      when Entry::TYPE[:note]
        # @todo2 add the context of the note if possible
        "*** @knote #{page(entry)}\n\#+begin_quote\n#{entry.text.strip}\n\#+end_quote"
      else
        "*** #{entry.text.strip}"
      end
    end

    def item_desc(entry)
      return entry.desc unless entry.desc_parsed?

      case entry.type
      when Entry::TYPE[:bookmark]
        time(entry)
      else
        (type(entry) + " @ " + page(entry) + " " + time(entry)).strip
      end
    end

    def page(entry)
      ((entry.page.nil? ? "" : "page #{entry.page}, ") +
        (entry.loc.nil? ? "" : "loc. #{entry.loc}")).delete_suffix(", ")
    end

    def time(entry)
      @config["time"] ? "[#{entry.time}]" : ""
    end

    def type(entry)
      SINGULAR[entry.type]
    end
  end
end
