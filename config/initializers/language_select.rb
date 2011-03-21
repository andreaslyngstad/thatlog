# CurrencySelect
module ActionView
  module Helpers
    module FormOptionsHelper
      # Return select and option tags for the given object and method, using
      # currency_options_for_select to generate the list of option tags.
      def language_select(object, method, priority_languages = nil, options = {}, html_options = {})
        InstanceTag.new(object, method, self, options.delete(:object)).to_language_select_tag(priority_languages, options, html_options)
      end
      
      # Returns a string of option tags. Supply a currency name as +selected+ 
      # to have it marked as the selected option tag. You can also supply an
      # array of currencies as +priority_currencies+, so that they will be
      # listed above the rest of the (long) list.
      #
      # NOTE: Only the option tags are returned, you have to wrap this call
      # in a regular HTML select tag.
      
      def language_options_for_select(selected = nil, priority_languages = nil)
        language_options = ""

        if priority_languages
          language_options += options_for_select(priority_languages, selected)
          language_options += "<option value=\"\" disabled=\"disabled\">------</option>\n"
        end

        return language_options + options_for_select(LANGUAGES, selected)
      end
      # All the currencies included in the currency_options output.
      LANGUAGES = [
        ["English", "en"],
        ["Norsk", "no"],
        
      ] unless const_defined?("LANGUAGES")
    end
    
    class InstanceTag
      def to_language_select_tag(priority_languages, options, html_options)
        html_options = html_options.stringify_keys
        add_default_name_and_id(html_options)
        value = value(object)
        content_tag("select",
          add_options(
            language_options_for_select(value, priority_languages),
            options, value
          ), html_options
        )
      end
    end
    
    class FormBuilder
      def language_select(method, priority_languages = nil, options = {}, html_options = {})
        @template.language_select(@object_name, method, priority_languages, options.merge(:object => @object), html_options)
      end
    end
  end
end