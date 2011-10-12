source "http://rubygems.org"

gem "heroku"
gem "haml"
gem "sass", :require => "sass/plugin/rack"
gem "rack-codehighlighter", :require => "rack/codehighlighter"
gem "rack-rewrite", :require => "rack/rewrite"

if ENV['RACK_ENV'] == "development"
  gem "toto", :path => "../toto"
else
	gem "toto", :git => "git://github.com/AndrewKvalheim/toto.git"
end

group :development do
  gem "rake"
  gem "shotgun"
end
