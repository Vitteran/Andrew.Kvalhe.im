# On-demand resource loader
@provider =
  resources:
    d3:
      url: 'http://d3js.org/d3.v2.min.js'
    google:
      url: 'https://www.google.com/jsapi'
    ntc:
      url: 'assets/ntc.js'
  require: (keys..., callback) ->
    requests = keys.map (key) =>
      resource = @resources[key]
      resource.request ?= $.ajax
        dataType: 'script'
        cache: true
        url: resource.url
    $.when(requests...).done -> callback()

$ ->
  # Ticker
  max = $('div#poweredby ul li').length
  counter = 1
  setInterval ->
    $("div#poweredby ul li:nth-child(#{counter})")
    .animate
      opacity: 0
      top: '-3.6em'
      -> $(this).css
        top: '1.2em'

    counter++
    counter = 1 if counter > max

    $("div#poweredby ul li:nth-child(#{counter})")
    .css
      top: '1.2em'
    .animate
      opacity: 1
      top: 0
  , 2000
