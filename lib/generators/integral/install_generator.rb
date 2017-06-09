module Integral
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      desc "Creates Integral, Carrierwave & CarrierwaveBackgrounder initializers"

      def copy_initializer_file
        copy_file "integral.rb", "config/initializers/integral.rb"
      end
    end
  end
end
