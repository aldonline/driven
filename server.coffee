jamesbundle        = require 'jamesbundle'
express            = require 'express'
_                  = require 'underscore'
async              = require 'async'
db                 = require './lib/db'
Blog               = require './lib/Blog'
config             = require './lib/config'
global_cache       = require './lib/global_cache'

app = express()

app.use express.compress()

require('./lib/googleapis/middleware') app

app.use express.static __dirname + '/public'

###
JamesBundle sets up javascript and css/less bundles
for us automatically ( a simple analog to Ruby's asset pipeline )
###
jb = jamesbundle production: config.production()
jb.mount app

app.get '/', (req, res) ->
  err = -> res.status(500)
  Blog.get ( e, blog ) ->
    return err() if e?
    blog.all ( e, docs ) ->
      return err() if e?
      res.send require('./lib/views/home')
        title:     blog.title()
        docs:      docs
        head_html: jb.html()

app.get '/doc/:id', ( req, res ) ->
  err = -> res.status(500)
  Blog.get ( e, blog ) ->
    return err() if e?
    blog.by_id req.params.id, ( e, doc ) ->
      return err() if e?
      if doc?
        res.send require('./lib/views/doc')
          doc:       doc
          head_html: jb.html()
      else
        res.status(404).send('Doc Not Found')


##############################################
# Admin
##############################################



app.get '/___admin___', (req, res) ->
  db.get_google_tokens (e, t) ->
    if t?
      message = ""
      unless t.refresh_token?
        message = """
          <p>Refresh token not present.
          <a href="https://accounts.google.com/b/0/IssuedAuthSubTokens">
            Try revoking all the tokens for this app
          </a>
          </p>
          """

      res.send """
        <a href="/___admin___/delete_tokens">Delete Tokens</a>
        #{message}
        <a href="/___admin___/reset_cache">Reset Cache</a>
      """
    else
      res.send '<a href="/auth/google">Set Google Token</a>'

app.get '/___admin___/delete_tokens', (req, res) ->
  db.delete_google_tokens (err) -> res.redirect '/___admin___'

app.get '/___admin___/reset_cache', (req, res) ->
  global_cache.reset()
  res.redirect '/___admin___'

app.listen config.port(), (e) ->
  if e? then throw e
  console.log "app listening on port " + config.port()