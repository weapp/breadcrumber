module Breadcrumber
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Copy Breadcrumber default files"
      source_root File.expand_path("../templates", __FILE__)

      def copy_initializer_file
        copy_file "breadcrumber.rb", "config/initializers/#{file_name}.rb"
      end
    end
  end
end