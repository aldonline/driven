
cache = {}

main = ( cli ) ->
  request: ( opts, cb, x ) ->
    cache_key = JSON.stringify opts # use a hash of the request
    if (entry = cache[cache_key])? 
      cb null, entry.body, entry.res
    else
      cb2 = ( err, body, res ) ->
        return cb? err if err?
        cache[cache_key] = {body, res}
        cb? null, body, res
      cli.request opts, cb2, x

main.reset = -> cache = {}

module.exports = main