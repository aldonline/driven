moment             = require 'moment'
get_doc            = require './googleapis/drive/get_doc'
get_docs_in_folder = require './googleapis/drive/get_docs_in_folder'
lazy               = require 'lazy_method'
async              = require 'async'
config             = require './config'
global_cache       = require './global_cache'


build = ( drive_file ) ->
  new Doc drive_file, drive_file.__html

module.exports =
  ###
  Fetch all docs in a given Google Drive folder
  ###
  in_folder: ( id, cb ) ->
    get_docs_in_folder id, (e, docs) ->
      return cb e if e?
      cb null, ( build doc for doc in docs )

  ###
  Fetch a set of docs ( in parallel )
  ###
  get_many: ( ids, cb ) ->
    async.map ids, _get, (r) -> cb? e, r

  ###
  Fetch one document by ID
  ###
  get: _get = ( id, cb ) -> global_cache id, cb, ( cb ) ->
    get_doc id, ( e, doc ) ->
      return cb e if e?
      cb null, build doc


class Doc
  ###
  This class is a view on top if three objects:
  @f = the Google Drive file object returned by the Drive API
  @h = the HTML object resulting from processing the text/html version of the file
  @m = the metadata extracted from the text/html version of the file
       ( the ```metadata ... ``` block )
  ###
  constructor: (@f, @h) ->
    @m = @h.metadata or {}

  title:       lazy -> @h.title or @f.title
  subtitle:    lazy -> @h.subtitle
  description: lazy -> @subtitle() # TODO
  pdf_link:    lazy -> @f.exportLinks['application/pdf']
  tags_html:   lazy -> ( '<a href="#"><span class="label">' + tag + '</span></a>' for tag in @tags() ).join '\n'
  body:        lazy -> @h.body
  id:          lazy -> @f.id
  image:       lazy -> @h.image or ''
  url:         lazy -> '/doc/' + @id()
  styles:      lazy -> @h.styles
  created:     lazy -> moment( new Date @f.createdDate ).fromNow()
  modified:    lazy -> moment( new Date @f.modifiedDate ).fromNow()
  tags:        lazy -> try t.trim() for t in @m.tags.split(','); catch e then []
  metadata:    lazy -> @m

  # these are the meta tags that go inside the <head> ... </head>
  meta_tags:   lazy ->
    metas = require('./meta_tags')
      title:          @title()
      description:    @subtitle()
      url:            @url()
      image:          @image()
      # TODO: take these from the index document
      facebook_id:    config.facebook_id()
      google_plus_id: config.google_plus_id()
    metas.join '\n'

  line_html:   lazy ->
    """
    <div class="media">
      <a class="pull-left media-thumb"
         href="#{@url()}"
         style="background-image: url(#{@image()});"
         >
      </a>
      <div class="media-body">
        <h4 class="media-heading">
          <a href="#{@url()}">#{@title()}</a>
        </h4>
        <p>#{@description()}</p>
        <p>Created: #{@created()} | Modified: #{@modified()}</p>
        <p>#{@tags_html()}</p>
      </div>
    </div>
    """