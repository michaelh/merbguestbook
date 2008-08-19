module Merb
  module Admin
    module EntriesHelper
      
      def toggleShowText(entry)
        if entry.show
          _'HIDE'
        else
          _'SHOW'
        end
      end
      
    end
  end
end
