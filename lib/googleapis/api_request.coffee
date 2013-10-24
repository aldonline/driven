googleapis = require 'googleapis'

module.exports = ( {api, version, req, cb} ) ->
  require('./authenticated_oauth2client') ( e, auth_cli ) ->
    return cb e if e?
    googleapis.discover(api, version).execute ( e, client ) ->
      return cb? e if e?
      req(client).withAuthClient(auth_cli).execute cb