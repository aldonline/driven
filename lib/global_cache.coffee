cache = {}

###

( key, generator ) -> # sync
( key, cb, generator ) -> # async

TODO: join all async calls

###
module.exports = main = ( key, func1, func2 ) ->

  if typeof func2 is 'function' # async
    cb        = func1
    generator = func2
  else
    generator = func1

  present = key of cache

  v = cache[key]
  
  if cb? # async
    process.nextTick -> # make sure we never return async.
                        # bad practice ( caller assumes async )
    if present
      cb null, v
    else
      generator (e, r) ->
        return cb e if e?
        cache[key] = r
        cb null, r
  else # sync
    if present
      v
    else
      cache[key] = generator()

main.reset =  ( key_filter ) ->
  if typeof key_filter is 'function'
    keys_to_delete = ( k for own k, v of cache when key_filter(k) )
    delete cache[k] for k in keys_to_delete
  else if typeof key_filter is 'string'
    delete cache[key_filter]
  else # all
    cache = {}