url     = require 'url'

###
takes a drive file object
and returns an HTML object
###

# in mem cache
html_cache = {}
setInterval ( -> html_cache = {} ), 1000 * 60 * 60 * 24 # one day

module.exports = ( doc_object, cb ) ->
  etag = doc_object.etag
  link = doc_object.exportLinks['text/html']
  key = etag + ' ' + link
  if ( r = html_cache[key] )?
    # value is cached
    cb null, r
  else
    # not in cache. let's fetch it
    get_raw_html link, (e, raw_html) ->
      return cb e if e?
      # process it
      require('../../../html_processor/process') raw_html, (e, r) ->
        html_cache[key] = r
        cb null, r


get_raw_html = ( link, cb ) ->
  ###
  uri: 'https://www.googleapis.com//drive/v2/files/1rwG68SWkLBBKuriYDJ5QDYbs-MECGNJLVoXwx9bvxKU',
  path: '/drive/v2/files/1rwG68SWkLBBKuriYDJ5QDYbs-MECGNJLVoXwx9bvxKU',
  method: 'GET',
  json: undefined,
  headers:
  ###
  parts = url.parse link

  opts =
    method: 'GET'
    uri:    link
    path:   parts.path
    json:   undefined

  require('../../authenticated_oauth2client') (e, cli) ->
    return cb e if e?
    cli.request opts, (err, body, res) ->
      return cb err if err?
      cb err, body


