module Slugify
  module SlugifyConcern

    extend ActiveSupport::Concern
    
    included do
      before_save :slugify

      validates :name, presence: true
      validates :slug, uniqueness: true, unless: :skip_uniqueness?
    end

    def to_param
      "#{self.slug}"
    end

    def slugify
      if self.slug_changed? and ! self.slug.blank?
        self.slug = self.slug.parameterize.gsub('%', '')
      elsif self.slug.blank?
        self.slug = self.name.parameterize.gsub('%', '')
      end
    end

    def dynamic_path
      p = "/"

      if self.respond_to? :section and ! self.section.nil?
        p << "#{self.section.slug}/"
      end

      p << self.slug
    end

    def actual_path
      if self.respond_to? :path and ! self.path.blank?
        self.path
      else
        self.dynamic_path
      end
    end

    module ClassMethods
      def reslug!
        self.all.each do |r|
          r.slugify
          r.update_column("slug", r.slug.parameterize.gsub('%', ''))
        end
      end
    end

    protected

    def skip_uniqueness?
      false
    end

  end
end