moment             = require 'moment'
get_doc            = require './googleapis/drive/get_doc'
get_docs_in_folder = require './googleapis/drive/get_docs_in_folder'
lazy               = require 'lazy_method'
async              = require 'async'


build = ( drive_file ) ->
  # console.log drive_file
  new Doc drive_file, drive_file.__html

module.exports =
  in_folder: ( id, cb ) ->
    get_docs_in_folder id, (e, docs) ->
      return cb e if e?
      cb null, ( build doc for doc in docs )

  get_many: ( ids, cb ) ->
    async.map ids, _get, (r) -> cb? e, r

  get: _get = ( id, cb ) ->
    get_doc id, ( e, doc ) ->
      return cb e if e?
      # console.log doc
      cb null, build doc

class Doc
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

  meta_tags:   lazy ->
    metas = require('./meta_tags')
      title:          @title()
      description:    @subtitle()
      url:            @url()
      image:          @image()
      facebook_id:    '545415493'
      google_plus_id: '102127397366064106648'
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