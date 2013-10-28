jamesbundle        = require 'jamesbundle'
express            = require 'express'
_                  = require 'underscore'
async              = require 'async'
db                 = require './lib/db'
gccw               = require './lib/googleapis/global_caching_client_wrapper'
Doc                = require './lib/Doc'
config             = require './lib/config'

app = express()

app.use express.compress()

require('./lib/googleapis/middleware') app

get_index = async.memoize ( cb ) -> Doc.get config.index_id(), cb
get_doc_ids = ( cb ) -> get_index ( e, r ) -> cb null, ( d.id for d in r.metadata().docs )
get_docs = ( cb ) -> get_doc_ids ( e, ids ) -> async.map ids, Doc.get, cb

app.use express.static __dirname + '/public'

jb = jamesbundle production: config.production()
jb.mount app

app.get '/', (req, res) ->
  get_docs (e, docs) ->
    res.send require('./lib/views/home') docs: docs, head_html: jb.html()

app.get '/doc/:id', ( req, res ) ->
  Doc.get req.params.id, ( e, doc ) ->
    res.send require('./lib/views/doc') doc: doc, head_html: jb.html()


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
        <pre>#{ JSON.stringify t, null, 2 }</pre>
        <a href="/___admin___/delete_tokens">Delete Tokens</a>
        #{message}
        <a href="/___admin___/reset_cache">Reset Cache</a>
      """
    else
      res.send '<a href="/auth/google">Set Google Token</a>'

app.get '/___admin___/delete_tokens', (req, res) ->
  db.delete_google_tokens (err) -> res.redirect '/___admin___'

app.get '/___admin___/reset_cache', (req, res) ->
  gccw.reset()
  res.redirect '/___admin___'

app.listen config.port(), (e) ->
  if e? then throw e
  console.log "app listening on port " + config.port()