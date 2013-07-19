%w{ models controllers helpers breadcrumber }.each do |dir|
  path = File.join(File.dirname(__FILE__), 'app', dir)
  $LOAD_PATH << path
  ActiveSupport::Dependencies.autoload_paths << path
  ActiveSupport::Dependencies.autoload_once_paths.delete(path)
end

module Breadcrumber
  module Breadcrumber
    extend ActiveSupport::Concern
    extend Configure

    included do
    end

    def add_literal_breadcrumb name, path = ''
      @breadcrumbs ||= []
      path = eval(path) if path =~ /_path|_url|@/
      name = truncate(name, length: truncate_length, separator: truncate_separator) if name =~ //
      @breadcrumbs << [name, path]
    end

    def add_breadcrumb name, path = ''
      add_literal_breadcrumb t(name), path
    end

    def add_safe_breadcrumb name, path = ''
      add_literal_breadcrumb t(name).html_safe, path
    end

    def add_home_breadcrumb
    end

    def add_base_breadcrumb
    end

    def add_item_breadcrumb
    end

    module ClassMethods
      def add_after_breadcrumb name, path, options = {}
        after_filter options do |controller|
          controller.send(:add_breadcrumb, name, path)
        end
      end

      def add_breadcrumb name, path, options = {}
        before_filter options do |controller|
          controller.send(:add_breadcrumb, name, path)
        end
      end

      def add_safe_breadcrumb name, path, options = {}
        before_filter options do |controller|
          controller.send(:add_safe_breadcrumb, name, path)
        end
      end

      def have_breadcrumbs(resource=nil)
        before_filter :add_home_breadcrumb
        before_filter :add_base_breadcrumb, except: :all
        before_filter :add_item_breadcrumb, except: [:all, :index, :new, :create]

        if resource
          add_breadcrumb "#{resource}.new", '', :only => [:new, :create]
          add_breadcrumb "#{resource}.edit", '', :only => [:edit, :update]
        end
      end
    end
  end
end


ActionController::Base.send :include, Breadcrumber::Breadcrumber
