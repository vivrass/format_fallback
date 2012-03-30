require "format_fallback/version"

module ActionView
  class PathSet

    def find_with_default_template(*args)
      prefixes = args[1]
      if prefixes.include?("layouts")
        # Layouts have their own way of managing fallback, better leave them alone
        find_without_default_template(*args)
      else
        options = args[3]
        options[:formats] << :html unless options[:formats].include?(:html)
        find_without_default_template(*args)
      end
    end
    alias_method_chain :find, :default_template

  end
  
=begin
  # This doesn't seem to be useful. Keep it until we can test in production with caching
  class Resolver
    
    def cached(key, prefix, name, partial)
      return yield unless key && caching?
      cache_content = yield
      if cache_content.empty?
        []
      else
        @cached[key][prefix][name][partial] ||= cache_content
      end
    end
    
  end
=end
end
