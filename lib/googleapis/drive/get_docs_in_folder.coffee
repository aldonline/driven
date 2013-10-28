async = require 'async'
_     = require 'underscore'

get_doc = require './get_doc'

module.exports = fd = ( id, cb ) ->
  fetch_doc = ( id, cb ) -> get_doc id, cb
  require('./drive_api_req')
    req: (client) -> client.drive.children.list folderId: id
    cb: (e, r) ->
      return cb e if e?
      async.map _.pluck(r.items,'id'), fetch_doc, (e, docs) ->
        return cb e if e?
        cb null, ( d for d in docs when d.__html? ) # folders won't have an HTML property