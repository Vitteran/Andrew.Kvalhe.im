require 'bundler'
Bundler.require(:default)

# Rack config
use Rack::Static, :urls => ['/images', '/favicon.ico'], :root => 'public'
use Rack::Static, :urls => ['/stylesheets'], :root => 'tmp'
use Rack::CommonLogger
use Rack::Rewrite do
  r302 %r{^/:([^/!]*)$}, 'http://static.andrew.kvalhe.im/assets/$1'
  r302 %r{^/:([^/!]*)!$}, 'http://static.andrew.kvalhe.im/assets/scaled/$1'
end
if ENV['RACK_ENV'] == 'development'
  use Rack::Static, :urls => ['/assets'], :root => '../content/cors-refugees'
else
  use Rack::Static, :urls => ['/assets'], :root => 'content/cors-refugees'
end

# Sass
use Sass::Plugin::Rack
Sass::Plugin.options.merge!(
  :template_location => 'public/stylesheets',
  :css_location => 'tmp/stylesheets'
)

# CoffeeScript
use Rack::Coffee,
  :root => 'public',
  :urls => '/scripts',
  :cache_compile => true,
  :cache_control => 7776000

# Syntax highlighting
use Rack::Codehighlighter, :pygments_api, :markdown => true, :element => "pre>code", :pattern => /\A:::(\w+)\s*(\n|&#x000A;)/i, :logging => true

if ENV['RACK_ENV'] == 'development'
  use Rack::ShowExceptions
end

# Custom kramdown extensions
class Kramdown::Parser::CustomExtensions < Kramdown::Parser::Kramdown
   def initialize(source, options)
     super
     @block_parsers.unshift(:coffeescript)
     @span_parsers.unshift(:instruction)
   end

  def parse_coffeescript
    @src.pos += @src.matched_size
    if coffeescript = @src.scan_until(/<\/script>/)
      javascript = CoffeeScript.compile(coffeescript)
      @tree.children << Element.new(:raw, "<script type=\"text/javascript\">#{javascript}</script>")
    end
  end
  define_parser(:coffeescript, /<script type="text\/coffeescript">/)

  def parse_instruction
    @src.pos += @src.matched_size

    el = Element.new()
    stop_re =
    found = parse_spans(el, stop_re)
  end
  define_parser(:instruction, /\[[^\]]*>[^\[]*\]/, '\[')
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
  set :url, 'http://Andrew.Kvalhe.im/'
  set :date, lambda {|now| now.strftime("%F")}
  set :disqus, 'kahve-toto'
  set :ext, 'md'
  if ENV['RACK_ENV'] == 'development'
    set :articles, '../content/articles'
  else
    set :articles, 'content/articles'
  end
  set :markdown,  {:input => 'CustomExtensions'}
  set :to_html, lambda {|path, page, context|
    ::Haml::Engine.new(File.read("#{path}/#{page}.haml"), :format => :html5, :ugly => true).render(context)
  }
  set :articles_per_page,    6                                # number of articles per page
  # set :error do |code|
  #   ::Haml::Engine.new(File.read("templates/pages/#{code}.haml"), :format => :html5, :ugly => true).render(@context)
  # end
end

run toto
