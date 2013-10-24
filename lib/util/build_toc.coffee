_ = require 'underscore'

heading_tag_names = ( 'h'+n for n in [1...10] )

module.exports = (container, $) ->
  class Node
    constructor: ( {@elm, @level})->
      @children = []
      @parent   = null
      @contents = []
    to_obj: ->
      href: @elm?.attr('href')
      text: @elm?.text()
      children: _.map @children, (c) -> c.to_obj()
  root = current = parent = new Node elm:container, level:0
  $(container).children().each ->
    if @tagName.toLowerCase() in heading_tag_names
      level = Number @tagName.substring 1
      current = new Node elm:@, level:level
      while level <= parent.level
        parent = parent.parent
      parent.children.push current
      current.parent = parent
      parent = current
    else
      current.contents.push @
  root