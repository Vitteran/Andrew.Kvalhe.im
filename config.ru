require 'bundler'
Bundler.require(:default)

# Rack config
use Rack::Static, :urls => ['/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::Static, :urls => ['/stylesheets'], :root => 'tmp'
use Rack::CommonLogger
use Rack::Rewrite do
  r302 %r{/assets/(.*)}, 'http://s3-us-west-2.amazonaws.com/andrew.kvalhe.im/assets/$1'
end

# Sass
use Sass::Plugin::Rack
Sass::Plugin.options.merge!(
  :template_location => 'public/stylesheets',
  :css_location => 'tmp/stylesheets'
)

# Syntax highlighting
use Rack::Codehighlighter, :pygments_api, :markdown => true, :element => "pre>code", :pattern => /\A:::(\w+)\s*(\n|&#x000A;)/i, :logging => true

if ENV['RACK_ENV'] == 'development'
  use Rack::ShowExceptions
end

#
# Create and configure a toto instance
#
toto = Toto::Server.new do
  # Add your settings here
  # set [:setting], [value]
  #
  # set :author,    ENV['USER']                               # blog author
  # set :title,     Dir.pwd.split('/').last                   # site title
  # set :root,      "index"                                   # page to load on /
  # set :date,      lambda {|now| now.strftime("%d/%m/%Y") }  # date format for articles
  # set :markdown,  :smart                                    # use markdown + smart-mode
  # set :disqus,    false                                     # disqus id, or false
  # set :summary,   :max => 150, :delim => /~/                # length of article summary and delimiter
  # set :ext,       'txt'                                     # file extension for articles
  # set :cache,      28800                                    # cache duration, in seconds
  set :author, 'Andrew'
  set :title, 'Andrew.Kvalhe.im'
  set :date, lambda {|now| now.strftime("%F")}
  set :disqus, 'kahve-toto'
  set :ext, 'md'
  if ENV['RACK_ENV'] == 'development'
    set :articles, 'tmp/articles'
  else
    set :articles, 'content/articles'
  end
  set :to_html, lambda {|path, page, context|
    ::Haml::Engine.new(File.read("#{path}/#{page}.haml"), :format => :html5, :ugly => true).render(context)
  }
  # set :error do |code|
  #   ::Haml::Engine.new(File.read("templates/pages/#{code}.haml"), :format => :html5, :ugly => true).render(@context)
  # end
end

run toto
