raml      = require 'raml'
build_toc = require './util/build_toc'
jb_util   = require 'jamesbundle/util'
# this will tell jamesbundle to use this as entry point

module.exports = (data) ->
  $ ->
    unless data.production
      jb_util.reloader.start()
    
    if $('.article-title').length is 0
      return

    build_toc_using_lis()

build_toc_using_lis = ->
  node_ui = ( node, depth ) ->
    a = $(node.elm).find 'a'
    text = a.text()
    href = a.attr 'href'
    ('.toc-line.toc-line-' + depth)._ ->
      'a'._ href:href, text
    if node.children.length > 0
      node_ui n, depth + 1 for n in node.children

  root = build_toc $('.article-container'), $
  
  $('.article-container').prepend 'a'._ name: 'top'

  toc = 'div.toc'._ ->
    '.toc-line.toc-line-home a.home-link'._ href: '/', '< Home'
    '.toc-line.toc-line-0 a.top-link'._ href: '#top', $('.article-title').text()

    node_ui c, 1 for c in root.children

  $('body').append toc