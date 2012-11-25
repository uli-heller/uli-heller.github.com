# -*- coding: utf-8 -*-
module Octopress
  module Date
    #Deutsche Lokalisation:
    MONTHNAMES_DE = [nil,
      "Januar", "Februar", "März", "April", "Mai", "Juni",
      "Juli", "August", "September", "Oktober", "November", "Dezember" ]
    ABBR_MONTHNAMES_DE = [nil,
      "Jan", "Feb", "Mär", "Apr", "Mai", "Jun",
      "Jul", "Aug", "Sep", "Okt", "Nov", "Dez" ]
    DAYNAMES_DE = [
      "Sonntag", "Montag", "Dienstag", "Mittwoch",
      "Donnerstag", "Freitag", "Samstag" ]
    ABBR_DAYNAMES_DE = [
      "So", "Mo", "Di", "Mi",
      "Do", "Fr", "Sa" ]

    # Returns a datetime if the input is a string
    def datetime(date)
      if date.class == String
        date = Time.parse(date)
      end
      date
    end

    # in _config.yml muss stehen: date_format: ordinal 
    def ordinalize(date)
      #**** hier Format bei Bedarf ändern, z.B. %A für ausgeschriebenen Wochentag    
      format_date(date, "%a, %e. %B %Y") # SA, 10. MÄRZ 2012
    end


    # Formats date either as ordinal or by given date format
    # Adds %o as ordinal representation of the day
    def format_date(date, format)
      myformat = format.dup
      date = datetime(date)
      if format.nil? || format.empty? || format == "ordinal"
        date_formatted = ordinalize(date) 
      else
        myformat.gsub!(/%a/, ABBR_DAYNAMES_DE[date.wday])
        myformat.gsub!(/%A/, DAYNAMES_DE[date.wday])
        myformat.gsub!(/%b/, ABBR_MONTHNAMES_DE[date.mon])
        myformat.gsub!(/%B/, MONTHNAMES_DE[date.mon])
        date_formatted = date.strftime(myformat)
        # date_formatted = date.strftime(format)
        # date_formatted.gsub!(/%o/, ordinal(date.strftime('%e').to_i))
      end
      date_formatted #+" ULI:#{date.mon}"
    end

  end

  module DateEn

    # Returns a datetime if the input is a string
    def datetime(date)
      if date.class == String
        date = Time.parse(date)
      end
      date
    end

    # Returns an ordidinal date eg July 22 2007 -> July 22nd 2007
    def ordinalize(date)
      date = datetime(date)
      "#{date.strftime('%b')} #{ordinal(date.strftime('%e').to_i)}, #{date.strftime('%Y')}"
    end

    # Returns an ordinal number. 13 -> 13th, 21 -> 21st etc.
    def ordinal(number)
      if (11..13).include?(number.to_i % 100)
        "#{number}<span>th</span>"
      else
        case number.to_i % 10
        when 1; "#{number}<span>st</span>"
        when 2; "#{number}<span>nd</span>"
        when 3; "#{number}<span>rd</span>"
        else    "#{number}<span>th</span>"
        end
      end
    end

    # Formats date either as ordinal or by given date format
    # Adds %o as ordinal representation of the day
    def format_date(date, format)
      date = datetime(date)
      if format.nil? || format.empty? || format == "ordinal"
        date_formatted = ordinalize(date)
      else
        date_formatted = date.strftime(format)
        date_formatted.gsub!(/%o/, ordinal(date.strftime('%e').to_i))
      end
      date_formatted
    end

  end
end


module Jekyll

  class Post
    include Octopress::Date

    # Convert this post into a Hash for use in Liquid templates.
    #
    # Returns <Hash>
    def to_liquid
      date_format = self.site.config['date_format']
      self.data.deep_merge({
        "title"             => self.data['title'] || self.slug.split('-').select {|w| w.capitalize! || w }.join(' '),
        "url"               => self.url,
        "date"              => self.date,
        # Monkey patch
        "date_formatted"    => format_date(self.date, date_format),
        "updated_formatted" => self.data.has_key?('updated') ? format_date(self.data['updated'], date_format) : nil,
        "id"                => self.id,
        "categories"        => self.categories,
        "next"              => self.next,
        "previous"          => self.previous,
        "tags"              => self.tags,
        "content"           => self.content })
    end
  end

  class Page
    include Octopress::Date

    # Initialize a new Page.
    #
    # site - The Site object.
    # base - The String path to the source.
    # dir  - The String path between the source and the file.
    # name - The String filename of the file.
    def initialize(site, base, dir, name)
      @site = site
      @base = base
      @dir  = dir
      @name = name

      self.process(name)
      self.read_yaml(File.join(base, dir), name)
      # Monkey patch
      date_format = self.site.config['date_format']
      self.data['date_formatted']    = format_date(self.data['date'], date_format) if self.data.has_key?('date')
      self.data['updated_formatted'] = format_date(self.data['updated'], date_format) if self.data.has_key?('updated')
    end
  end

  module Filters
    include Octopress::Date
    def date(date, format)
      format_date(date, format)
    end
  end
end
