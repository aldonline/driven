raml       = require 'raml'
build_toc  = require './util/build_toc'
rcell      = require 'reactive-supercell'
reactivity = require 'reactivity'

# this will tell jamesbundle to use this as entry point
jb_util   = require 'jamesbundle/util'

in_homepage = -> $('.article-title').length is 0

sizes = [ 500, 900 ]
app_size = reactivity 100, ->
  try 
    w = $(window).width()
    if w < sizes[0] then 1 else if w < sizes[1] then 2 else 3
  catch e
    3

module.exports = (data) ->
  $ ->
    # start the code reloader if not in production
    unless data.production
      jb_util.reloader.start()
    return if in_homepage()
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
  
  # build a tree data structure using the build_toc helper
  root = build_toc $('.article-body'), $
  
  # add a link to the top of the document
  # we will use it to "scroll to top"
  $('.article-container').prepend 'a'._ name: 'top'

  # build the TOC
  toc = 'div.toc'._ ->
    # first two LIs are hardcoded
    '.toc-line.toc-line-home a.home-link'._ href: '/', -> '< Home'
    '.toc-line.toc-line-0 a.top-link'._ href: '#top', $('.article-title').text()
    # the rest are derived from the actual TOC
    node_ui c, 1 for c in root.children

  # append the TOC to the document
  $('body').prepend toc