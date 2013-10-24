HTML = require './HTML'
_ = require 'underscore'

process_html = ( html_str, cb ) ->
  require('jsdom').env html_str, [], (e, window) ->
    return cb e if e?
    $ = require('jQuery').create window
    cb null, process_dom $


process_dom = ( $ ) ->
    title  =   $('.title').text()
    subtitle = $('.subtitle').text()
    image  =   $('img').attr 'src'

    # remove image
    $($('img')[0]).remove()

    process_code_segments $
    transform_headings_to_links $
    
    # -- TOC
    # for now we just remove it
    # a toc will be built automatically on the client side via JS
    remove_toc $

    replace_conflicting_style_names $
    styles =   $('style').html()

    summary = ''
    # TODO:
    # summary should be the first few paragraphs of text
    # which are not the TOC

    metadata = {}
    do ->
      codem = $('code[lang=metadata]')
      if codem.length isnt 0
        metadata = JSON.parse codem.text().replace /[\s]+/gi, " "
        codem.parent().remove()

    # remove title and subtitle
    # these will be added separately to the article
    $('.gdoc-title').remove()
    $('.gdoc-subtitle').remove()

    body  = $('body').html()

    new HTML {title, subtitle, styles, image, body, metadata, summary}


#################################################
#################################################
# HEADINGS
#################################################
#################################################

heading_tag_names = ( 'h'+n for n in [1...10] )

transform_headings_to_links = ( $ ) ->
  tags = []
  for n in heading_tag_names
    tags = tags.concat $(n).toArray()
  ###
  <h1 class="c1"><a name="h.2afzweis5bue"></a><span>XXX</span></h1>
  ###
  for t in tags
    t = $(t)
    text = t.text()
    name = t.find('a').attr 'name'
    t.children().remove()
    t.append $('<a>').attr(name:name, href:'#' + name).text text

#################################################
#################################################
# TOC
#################################################
#################################################

get_toc_links = ($) ->
  $('a').filter (i, e) ->
    e = $(e)
    href =  e.attr('href') # something like '#h.xxxyyyzzz'
    is_heading_a = href?.indexOf('#h.') is 0
    has_name = e.attr('name')?
    is_heading_a and not has_name

annotate_toc = ($) ->
  get_toc_links().each (i, e) ->
    e = $(e)
    href =  e.attr('href') # something like '#h.xxxyyyzzz'
    e.addClass 'gdoc-toc'
    # what level? ( h1, h2, etc )
    # find target heading
    h = $('a').filter (i,e) -> $(e).attr('name') is href.substr(1)
    tag = h.parent()[0].tagName.toLowerCase()
    e.addClass 'gdoc-toc-' + tag
  undefined

remove_toc = ($) -> get_toc_links($).parent().parent().remove()

#################################################
#################################################
# CSS
#################################################
#################################################


replace_conflicting_style_names = ( $ ) ->
  s = $('style').html()
  s = s.split('.title{').join '.gdoc-title{'
  s = s.split('.subtitle{').join '.gdoc-subtitle{'
  $('style').html s

  $('.title').removeClass('title').addClass('gdoc-title')
  $('.subtitle').removeClass('subtitle').addClass('gdoc-subtitle')



#################################################
#################################################
# CODE
#################################################
#################################################

replace_quotes = (str) ->
  reps = ['“”‘’','""'+"''"]
  for x, i in reps[0]
    str = str.replace (new RegExp x, 'g'), reps[1][i]
  str

process_code_segments = ( $ ) ->

  class CodeSegment
    constructor: ->
      @elms = []
    push: (e) -> @elms.push e
    lang: -> $(@elms[0]).text().replace('```','').trim()
    _lines: -> $(e).text() for e in @elms
    _code_lines: -> @_lines().concat()[1..-2]
    code: -> replace_quotes @_code_lines().join('\n')
    replace: ->
      codetag = $('<code>').attr(lang:@lang()).text @code()
      $('<pre>').append(codetag).insertAfter @elms[0]
      $(@elms).remove()
      undefined

  # find code sections
  find_code_sections = ->
    sections = []
    current = null
    $('body').children().each ->
      e = $(@)
      marker = e.text().indexOf('```') isnt -1
      if current?
        if marker
          current.push @
          current = null
        else
          current.push @
      else
        if marker
          sections.push current = new CodeSegment
          current.push @
    sections

  s.replace() for s in find_code_sections()
  undefined



#################################################
#################################################
# TESTING ON THE BROWSER
#################################################
#################################################

if window?
  if window.jQuery?
    console.log process_dom $
  else
    do ->
      jq = document.createElement('script');
      jq.src = "//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js";
      document.getElementsByTagName('head')[0].appendChild(jq);
else
  module.exports = process_html


  


