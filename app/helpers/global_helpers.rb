module Merb
  module GlobalHelpers
    
    def handleError(entry, col)
      errors = entry.errors[col]
      
      return if errors.nil?
      
      
      val = "<div class=\"errorText\">"

      for error in errors
        val << "#{_(error)}" << "<br/>"
      end
     
      val << "</div>"

      val
    end
    
    def showDate(entry, lang)
      if _(lang) == "DE"
        entry.created_at.strftime("%d.%m.%Y, %H:%M").to_s
      else
        entry.created_at.strftime("%d/%m/%Y, %I:%M %p").to_s
      end
    end

    def showText(entry)
      return h(entry.text).gsub("\n", "<br>")

    end

  end
end
