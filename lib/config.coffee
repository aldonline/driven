semver = require 'semver'

###
We take most configuration parameters
from env vars.
This makes it easy to configure the app for 
different environments (Heroku for instance)
###
env = process.env

# https://accounts.google.com/b/0/IssuedAuthSubTokens

# check node version
# we know that there is an SSL problem with older versions
# having the correct error can save us a lot of time and
# frustration

unless semver.satisfies process.version, '>=0.10.18'
  throw new Error 'This app requires Node.js >=0.10.18.
                   Older versions have an SSL error that breaks
                   the OAuth client we are using'

module.exports =
  mongo_url:       -> env.MONGO_URL
  folder_id:       -> env.FOLDER_ID
  index_id:        -> env.INDEX_DOC_ID
  facebook_id:     -> env.FACEBOOK_ID
  google_plus_id:  -> env.GOOGLE_PLUS_ID
  port:            -> env.PORT or 9000
  production:      -> process.env.NODE_ENV is 'production'

  googleapis:
    client_id:     -> env.GOOGLE_APPS_ID
    client_secret: -> env.GOOGLE_APPS_SECRET
    redirect_url:  -> env.GOOGLE_OAUTH_REDIRECT_URL
    scope: ->
      [
        'https://www.googleapis.com/auth/drive.readonly'
      ].join ' '