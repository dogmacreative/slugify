require "slugify/version"
require "slugify/slugify_concern"
require "slugify/has_slug"

module Slugify
  class Engine < ::Rails::Engine
  end
end

ActiveSupport.on_load(:active_record) do
  include Slugify::Model
end