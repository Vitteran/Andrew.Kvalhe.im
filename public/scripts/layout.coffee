$ ->
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
