source "http://rubygems.org"

gem "thin"
gem "heroku"
gem "haml"
gem "sass", :require => "sass/plugin/rack"
gem "rack-coffee", :require => "rack/coffee"
gem "rack-codehighlighter", :require => "rack/codehighlighter"
gem "rack-rewrite", :require => "rack/rewrite"

if ENV['RACK_ENV'] == "development"
  gem "toto", :path => "../engine"
else
  gem "toto", :git => "git://github.com/AndrewKvalheim/toto.git"
end

group :development do
  gem "rake"
  gem "shotgun"
end
