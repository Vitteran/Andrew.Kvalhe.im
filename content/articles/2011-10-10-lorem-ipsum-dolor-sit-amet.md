# Lorem ipsum dolor sit amet

Praesent et purus sed dolor malesuada semper. Fusce laoreet facilisis est ac placerat.

Phasellus sit amet sagittis risus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nulla non magna nibh, sed fringilla sapien. Cras in urna quis justo suscipit facilisis.

    :::ruby
    require 'bundler'
    Bundler.require(:default)

    # Rack config
    use Rack::Static, :urls => ['/js', '/images', '/favicon.ico'], :root => 'public'
    use Rack::Static, :urls => ['/stylesheets'], :root => 'tmp'
    use Rack::Static, :urls => ['/attachments'], :root => 'content'
    use Rack::CommonLogger

    # Sass
    use Sass::Plugin::Rack
    Sass::Plugin.options.merge!(
      :template_location => 'public/stylesheets',
      :css_location => 'tmp/stylesheets'
    )

Suspendisse ante massa, tincidunt a rutrum ac, ornare at est. Fusce vestibulum felis eget elit semper nec laoreet nunc vestibulum. Phasellus cursus, urna eget cursus venenatis, nibh mi porta erat, vel cursus felis massa vitae neque. Maecenas sed pretium velit. Maecenas malesuada, est id scelerisque luctus, tellus dolor condimentum nibh, sed convallis metus diam non felis.
