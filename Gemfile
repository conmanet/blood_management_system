source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.0.2"
gem "mysql2"
gem "puma", "~> 3.0"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "jbuilder", "~> 2.5"
gem "config"
gem "devise"
gem "jquery-rails"
gem "bootstrap-sass", "~> 3.3.6"
gem "font-awesome-rails"
gem "bootstrap-glyphicons"
gem "material_icons"
gem "cancancan"
gem "carrierwave"
gem "mini_magick"
gem "cloudinary"
gem "config"
gem "bcrypt"
gem "ransack"
gem "activemodel-serializers-xml"
gem "draper", github: "audionerd/draper", branch: "rails5"
gem "kaminari"
gem "momentjs-rails"
gem "select2-rails"
gem "ckeditor"
gem "social-share-button"
gem "jquery-ui-rails"
gem "faker"
gem "addressable"

group :development, :test do
  gem "pry-rails"
  gem "awesome_print"
  gem "binding_of_caller"
  gem "better_errors"
  gem "dotenv-rails"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.0.5"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
