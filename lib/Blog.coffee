async              = require 'async'
Doc                = require './Doc'
config             = require './config'
global_cache       = require './global_cache'

###
One Blog has many docs
###
module.exports = class Blog
  constructor: ( @id, @meta ) ->

  title: -> @meta.title

  _ids: -> ( d.id for d in @meta.docs )

  ###
  Returns all docs
  ###
  all: ( cb ) ->
    async.map @_ids(), Doc.get, cb

  by_id: ( id, cb ) ->
    if id in @_ids() # only allow docs listed on the index
      Doc.get id, cb
    else
      cb null, null

  # for now there is only one global Blog
  # in a ( future ) multi-user setup there
  # should be one blog per google acct
  @get: ( cb ) ->
    id = config.index_id()
    global_cache "blog_#{id}", cb, ( cb ) ->
      # 1. get the index doc
      Doc.get id, ( e, idx_doc ) ->
        return cb e if e? 
        # create new instance
        # TODO: cache
        cb null, new Blog id, idx_doc.metadata()