

env = process.env

# https://accounts.google.com/b/0/IssuedAuthSubTokens

module.exports =
  mongo_url:       -> env.MONGO_URL
  folder_id:       -> env.FOLDER_ID
  index_id:        -> env.INDEX_ID
  port:            -> env.PORT or 9000
  production:      -> process.env.NODE_ENV is 'production'

  googleapis:
    client_id:     -> env.CLIENT_ID
    client_secret: -> env.CLIENT_SECRET
    redirect_url:  -> env.REDIRECT_URL
    scope: ->
      arr = [
        #'https://www.googleapis.com/auth/calendar'
        #'https://www.googleapis.com/auth/plus.me'
        'https://www.googleapis.com/auth/drive.readonly'
      ]
      arr.join ' '

