c    = require './oauth2client'
db   = require '../db'
eccw = require './etag_caching_client_wrapper'
gccw = require './global_caching_client_wrapper'
rccw = require './retry_403_client_wrapper'

###
{ access_token: 'ya29.AHES6ZQs4uGjXvtyYyaDBso9Iy-jQKQrLcOctR4EkBW7u5jeTPZHfw',
  token_type: 'Bearer',
  expires_in: 3600,
  id_token: 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjRlNDZiMGQ4Zjg1OWRhMDNjOGM3MmY5YTM3ZWM0NTFjM2RjNTM0NmUifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwidG9rZW5faGFzaCI6IkphS3VhcDJTWnB4YzZnT28tTzFjNFEiLCJhdF9oYXNoIjoiSmFLdWFwMlNacHhjNmdPby1PMWM0USIsImlkIjoiMTAyMTI3Mzk3MzY2MDY0MTA2NjQ4Iiwic3ViIjoiMTAyMTI3Mzk3MzY2MDY0MTA2NjQ4IiwiY2lkIjoiNjQ1OTg3OTU2NTg3LTYyMzk0ZmU3cDhkMTRmZW5wcXMwY21rbTZyb2NiN2ZoLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwiYXpwIjoiNjQ1OTg3OTU2NTg3LTYyMzk0ZmU3cDhkMTRmZW5wcXMwY21rbTZyb2NiN2ZoLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwiYXVkIjoiNjQ1OTg3OTU2NTg3LTYyMzk0ZmU3cDhkMTRmZW5wcXMwY21rbTZyb2NiN2ZoLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwiaWF0IjoxMzc5MzA1NTEwLCJleHAiOjEzNzkzMDk0MTB9.RWNjHKshgHoQttoBK3-W6v_3Gb1CFnyCWi-KOdefd-0sJeLuJw7lx7ezGzUrcGHHW2ddrUpqPtvM8hfQmkfb2XHp3d3b8M9HEwiLJVJm4mpaQUEDJeRCJvI4n3itv5Rk1pC8qpHtBruE30hnAvmrr29eo_eBZ6O3Lj48TnO95sM',
  refresh_token: '1/xia1oIR6QCdiFQ3Wvh82vTf9aSi-KFe6PtQpqooi_AQ' }
###


_tokens = null
setInterval ( -> _tokens = null ), 1000 * 60 * 5 # clear cache every 5 minutes
get_tokens = ( cb ) ->
  return cb null, _tokens if _tokens?
  db.get_google_tokens (e, t) ->
    return cb e if e?
    return cb new Error 'No valid tokens available' unless t?
    cb null, _tokens = t

module.exports = ( cb ) ->
  get_tokens (e, t) ->
    return cb e if e?
    cli = c()
    cli.credentials =
      access_token:  t.access_token
      refresh_token: t.refresh_token
    cb null,  gccw eccw rccw cli