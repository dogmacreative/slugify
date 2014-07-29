module Slugify
	module Model

		def self.included(base)
		  base.send :extend, ClassMethods
		end

    module ClassMethods

      def has_slug
        include Slugify::SlugifyConcern
      end

    end

	end
end