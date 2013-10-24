config   = require './config'
MongoClient = require('mongodb').MongoClient

###
Combinator ( loan pattern )
Lends a Database
###
with_db = ( f ) ->
  MongoClient.connect config.mongo_url(), ( err, db ) ->
    return f err if err?
    f null, db, -> db.close()

###
Combinator ( loan pattern )
Lends a Collection
###
with_coll = ( coll, f ) ->
  with_db ( err, db, close ) ->
    return f err if err?
    try
      f null, db.collection( coll ), close
    catch e
      f e

module.exports =

  save_google_tokens: ( tokens, cb ) ->
    with_coll 'tokens', ( err, coll, close ) ->
      coll.insert tokens, ( err, docs ) ->
        close?()
        cb? err

  get_google_tokens: ( cb ) ->
    console.log 'get tokens...'
    with_coll 'tokens', ( err, coll, close ) ->
      coll.find().toArray ( err, results ) ->
        return cb err if err?
        if results.length is 0
          cb null, null
        else
          cb null, results[results.length - 1]
        console.log 'got tokens ', results
        close?()
  
  delete_google_tokens: ( cb ) ->
    with_coll 'tokens', ( err, coll, close ) ->
      coll.remove ( err ) ->
        close?()
        cb? err