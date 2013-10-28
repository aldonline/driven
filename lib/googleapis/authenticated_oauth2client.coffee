c    = require './oauth2client'
db   = require '../db'
eccw = require './etag_caching_client_wrapper'
rccw = require './retry_403_client_wrapper'


_tokens = null
setInterval ( -> _tokens = null ), 1000 * 60 * 5 # clear token cache every 5 minutes
get_tokens = ( cb ) ->
  return cb null, _tokens if _tokens?
  db.get_google_tokens (e, t) ->
    return cb e if e?
    return cb new Error 'No valid tokens available' unless t?
    ###
    t = {
      access_token:   'xxx',
      token_type:     'Bearer',
      expires_in:     3600,
      id_token:       'yyy',
      refresh_token:  'zzz'
    }
    ###
    cb null, _tokens = t

module.exports = ( cb ) ->
  get_tokens (e, t) ->
    return cb e if e?
    cli = c()
    cli.credentials =
      access_token:  t.access_token
      refresh_token: t.refresh_token
    cb null, eccw rccw cli