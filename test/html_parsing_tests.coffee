chai = require 'chai'
should = chai.should()


jQuery = require 'jQuery'


html_2_jQuery = ( raw_html ) ->
  $ = jQuery.create()
  raw_html = raw_html.replace '<html>', ''
  raw_html = raw_html.replace '</html>', ''
  $('html').html raw_html
  $

jQuery_2_html = ( $ ) ->
  '<html>' + $('html').html() + '</html>'


html = """
<html><head><title>headers_1</title><meta content="text/html; charset=UTF-8" http-equiv="content-type"><style type="text/css">ol{margin:0;padding:0}.c8{max-width:468pt;background-color:#ffffff;padding:72pt 72pt 72pt 72pt}.c2{color:inherit;text-decoration:inherit}.c3{color:#1155cc;text-decoration:underline}.c0{direction:ltr}.c1{height:11pt}.c4{margin-left:54pt}.c5{margin-left:18pt}.c6{margin-left:36pt}.c7{margin-left:72pt}.title{padding-top:0pt;line-height:1.15;text-align:left;color:#000000;font-size:21pt;font-family:"Trebuchet MS";padding-bottom:0pt}.subtitle{padding-top:0pt;line-height:1.15;text-align:left;color:#666666;font-style:italic;font-size:13pt;font-family:"Trebuchet MS";padding-bottom:10pt}li{color:#000000;font-size:11pt;font-family:"Arial"}p{color:#000000;font-size:11pt;margin:0;font-family:"Arial"}h1{padding-top:10pt;line-height:1.15;text-align:left;color:#000000;font-size:16pt;font-family:"Trebuchet MS";padding-bottom:0pt}h2{padding-top:10pt;line-height:1.15;text-align:left;color:#000000;font-size:13pt;font-family:"Trebuchet MS";font-weight:bold;padding-bottom:0pt}h3{padding-top:8pt;line-height:1.15;text-align:left;color:#666666;font-size:12pt;font-family:"Trebuchet MS";font-weight:bold;padding-bottom:0pt}h4{padding-top:8pt;line-height:1.15;text-align:left;color:#666666;font-size:11pt;text-decoration:underline;font-family:"Trebuchet MS";padding-bottom:0pt}h5{padding-top:8pt;line-height:1.15;text-align:left;color:#666666;font-size:11pt;font-family:"Trebuchet MS";padding-bottom:0pt}h6{padding-top:8pt;line-height:1.15;text-align:left;color:#666666;font-style:italic;font-size:11pt;font-family:"Trebuchet MS";padding-bottom:0pt}</style></head><body class="c8"><p class="c0"><span>This is going to be a document with headers</span></p><p class="c0 c1"><span></span></p><p class="c0 c1"><span></span></p><p class="c0 c1"><span></span></p><p class="c0 c5"><span class="c3"><a class="c2" href="#h.rgtrl3c6uz6l">header1</a></span></p><p class="c0 c6"><span class="c3"><a class="c2" href="#h.t183qomy642l">header11</a></span></p><p class="c0 c4"><span class="c3"><a class="c2" href="#h.egub2dw3z6ec">header111</a></span></p><p class="c0 c7"><span class="c3"><a class="c2" href="#h.suaw9pmxc1ma">header1111</a></span></p><p class="c0 c4"><span class="c3"><a class="c2" href="#h.6qbf5sr5xkhj">header112</a></span></p><p class="c0 c6"><span class="c3"><a class="c2" href="#h.lx5ky9bbgnms">header12</a></span></p><p class="c0 c5"><span class="c3"><a class="c2" href="#h.a9xgtcuhaliz">header2</a></span></p><p class="c0 c5"><span class="c3"><a class="c2" href="#h.wvnqxbuhbsms">header3</a></span></p><p class="c0 c6"><span class="c3"><a class="c2" href="#h.6hogk7jrsvow">header31</a></span></p><p class="c0 c1"><span></span></p><p class="c0 c1"><span></span></p><p class="c0 c1"><span></span></p><h1 class="c0"><a name="h.rgtrl3c6uz6l"></a><span>header1</span></h1><p class="c0 c1"><span></span></p><p class="c0"><span>text</span></p><p class="c0 c1"><span></span></p><h2 class="c0"><a name="h.t183qomy642l"></a><span>header11</span></h2><p class="c0 c1"><span></span></p><p class="c0"><span>text</span></p><p class="c0 c1"><span></span></p><p class="c0"><span class="c3"><a class="c2" href="#id.rdi1hnot2hsg">link to a bookmark</a></span></p><p class="c0 c1"><span></span></p><h3 class="c0"><a name="h.egub2dw3z6ec"></a><span>header111</span></h3><p class="c0 c1"><span></span></p><p class="c0"><span>text</span></p><p class="c0 c1"><span></span></p><a href="#" name="id.rdi1hnot2hsg"></a><p class="c0"><span>a bookmark</span></p><p class="c0 c1"><span></span></p><h4 class="c0"><a name="h.suaw9pmxc1ma"></a><span>header1111</span></h4><p class="c0 c1"><span></span></p><p class="c0"><span>text</span></p><p class="c0 c1"><span></span></p><h3 class="c0"><a name="h.6qbf5sr5xkhj"></a><span>header112</span></h3><p class="c0 c1"><span></span></p><p class="c0"><span>text</span></p><h2 class="c0"><a name="h.lx5ky9bbgnms"></a><span>header12</span></h2><p class="c0 c1"><span></span></p><p class="c0"><span>fooo</span></p><p class="c0 c1"><span></span></p><h1 class="c0"><a name="h.a9xgtcuhaliz"></a><span>header2</span></h1><p class="c0 c1"><span></span></p><p class="c0"><span>text</span></p><p class="c0 c1"><span></span></p><h1 class="c0"><a name="h.wvnqxbuhbsms"></a><span>header3</span></h1><p class="c0 c1"><span></span></p><p class="c0"><span>text</span></p><h2 class="c0"><a name="h.6hogk7jrsvow"></a><span>header31</span></h2><p class="c0 c1"><span></span></p><p class="c0"><span>text</span></p></body></html>
"""

parse = ( raw_html_str ) ->
  $ = html_2_jQuery raw_html_str
  console.log $('style').html()


class DocHtml
  constructor: ( @raw_html ) ->
    @$ = html_2_jQuery @raw_html
  styles: -> @$('style').html()
  body:   -> @$('body').html()


remove_toc = ->
  



parse html

###
Get Google Docs from a predefined folder
###

###
describe.only 'foo', ->
  docs = null
  it 'should fetch docs from folder', (done) ->
###


