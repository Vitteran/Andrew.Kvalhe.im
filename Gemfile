source "http://rubygems.org"

gem "heroku"
gem "haml"
gem "sass", :require => "sass/plugin/rack"

if ENV['RACK_ENV'] == "development"
  gem "toto", :path => "../toto"
else
	gem "toto", :git => "git://github.com/AndrewKvalheim/toto.git"
end

group :development do
  gem "rake"
  gem "shotgun"
end
