module.exports = ( cli ) ->
  request: ( opts, cb, x ) ->
    retries = 0
    do iter = ->
      cb2 = ( err, body, res ) ->
        return cb? err if err?
        # does anyone know of a better way to do this?
        t = body.toString().indexOf('<TITLE>User Rate Limit Exceeded</TITLE>') isnt -1
        if t or res.statusCode is 403
          console.log 403, 'retries', retries
          if retries++ > 5
            cb err, body, res
          else
            setTimeout iter, retries * 1000 # linear backoff. someone plz change this to exp
        else
          if retries > 0
            console.log 'succeded after retry N ' + retries
          cb null, body, res
      cli.request opts, cb2, x