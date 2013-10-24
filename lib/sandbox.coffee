get_cli = require './googleapis/authenticated_oauth2client'
request = require 'request'

###
{
  "uri":"https://www.googleapis.com//drive/v2/files/0BwQ-i_0r4A6gZjIwMWQzNWItMjU3MC00MTk0LTlmZGYtYTRjYjdiYWJiYWU5/children",
  "path":"/drive/v2/files/0BwQ-i_0r4A6gZjIwMWQzNWItMjU3MC00MTk0LTlmZGYtYTRjYjdiYWJiYWU5/children",
  "method":"GET",
  "headers":{
    "Authorization":"Bearer ya29.AHES6ZTr_APG3VHGEyW6mjATBtUGCjU5OsNBYat4JcFkKB2-OttvnQ",
    "User-Agent":"google-api-nodejs-client/0.4.5"
    }
  }
###

json_clone = (obj) -> JSON.parse JSON.stringify obj


cache = {}
# cache will keep a reference to the request/response
# which in turn keep a reference to some low level connection/sockets etc
# just in case, we kill the cache once every day
setInterval ( -> cache = {} ), 1000 * 60 * 60 * 24


caching_client_wrapper = ( cli ) ->

  request: ( opts, cb, x ) ->
    opts_copy = json_clone opts
    cache_key = JSON.stringify opts # use a hash of the request
    if (entry = cache[cache_key])? 
      ( opts_copy.headers ?= {} )['If-None-Match'] = entry.res.headers.etag
    cb2 = ( err, body, res ) ->
      return cb err if err?
      console.log res.statusCode
      if res.statusCode not in [ 200, 304 ]
        return cb err, body, res
      if res.statusCode is 200 then cache[cache_key] = {res, body}
      cb null, cache[cache_key].body, cache[cache_key].res
    cli.request opts_copy, cb2, x

opts = 
  "uri":"https://www.googleapis.com//drive/v2/files/0BwQ-i_0r4A6gZjIwMWQzNWItMjU3MC00MTk0LTlmZGYtYTRjYjdiYWJiYWU5/children"
  "path":"/drive/v2/files/0BwQ-i_0r4A6gZjIwMWQzNWItMjU3MC00MTk0LTlmZGYtYTRjYjdiYWJiYWU5/children"
  "method":"GET"
  "headers":{}
    #"Authorization":"Bearer ya29.AHES6ZTr_APG3VHGEyW6mjATBtUGCjU5OsNBYat4JcFkKB2-OttvnQ"
    #"User-Agent":"google-api-nodejs-client/0.4.5"

# request opts, -> console.log arguments
get_cli (e, c) ->

  c = caching_client_wrapper c
  console.log 'zero'
  c.request opts, (e, b, r) ->
    console.log 'first'
    c.request opts, ( e, b, r ) ->
      console.log 'second'
      c.request opts, ( e, b, r ) ->
        console.log 'third'

