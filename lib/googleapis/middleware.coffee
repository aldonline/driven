googleapis = require 'googleapis'
db         = require '../db'
config     = require('../config').googleapis
oac        = require './oauth2client'

###
Sets up the routes on the express server
###
module.exports = ( app ) ->
  cli = oac()
  url = cli.generateAuthUrl
    access_type: 'offline'
    scope: config.scope()
  app.get '/auth/google', (req, res) -> res.redirect url
  app.get '/auth/google/redirect', (req, res, next) ->
    cli.getToken req.query.code, (err, tokens) ->
      ###
      { access_token: 'ya29.AHES6ZQs4uGjXvtyYyaDBso9Iy-jQKQrLcOctR4EkBW7u5jeTPZHfw',
        token_type: 'Bearer',
        expires_in: 3600,
        id_token: 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjRlNDZiMGQ4Zjg1OWRhMDNjOGM3MmY5YTM3ZWM0NTFjM2RjNTM0NmUifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwidG9rZW5faGFzaCI6IkphS3VhcDJTWnB4YzZnT28tTzFjNFEiLCJhdF9oYXNoIjoiSmFLdWFwMlNacHhjNmdPby1PMWM0USIsImlkIjoiMTAyMTI3Mzk3MzY2MDY0MTA2NjQ4Iiwic3ViIjoiMTAyMTI3Mzk3MzY2MDY0MTA2NjQ4IiwiY2lkIjoiNjQ1OTg3OTU2NTg3LTYyMzk0ZmU3cDhkMTRmZW5wcXMwY21rbTZyb2NiN2ZoLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwiYXpwIjoiNjQ1OTg3OTU2NTg3LTYyMzk0ZmU3cDhkMTRmZW5wcXMwY21rbTZyb2NiN2ZoLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwiYXVkIjoiNjQ1OTg3OTU2NTg3LTYyMzk0ZmU3cDhkMTRmZW5wcXMwY21rbTZyb2NiN2ZoLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwiaWF0IjoxMzc5MzA1NTEwLCJleHAiOjEzNzkzMDk0MTB9.RWNjHKshgHoQttoBK3-W6v_3Gb1CFnyCWi-KOdefd-0sJeLuJw7lx7ezGzUrcGHHW2ddrUpqPtvM8hfQmkfb2XHp3d3b8M9HEwiLJVJm4mpaQUEDJeRCJvI4n3itv5Rk1pC8qpHtBruE30hnAvmrr29eo_eBZ6O3Lj48TnO95sM',
        refresh_token: '1/xia1oIR6QCdiFQ3Wvh82vTf9aSi-KFe6PtQpqooi_AQ' }
      ###
      db.save_google_tokens tokens, ->
        res.redirect '/___admin___'