json_clone = (obj) -> JSON.parse JSON.stringify obj

cache = {}
# cache will keep a reference to the request/response
# which in turn keep a reference to some low level connection/sockets etc
# just in case, we kill the cache once every day
setInterval ( -> cache = {} ), 1000 * 60 * 60 * 24

module.exports = ( cli ) ->

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