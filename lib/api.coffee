get = require './googleapis/drive/get_docs_in_folder'

module.exports =
  docs: (folder_id, cb) ->
    get folder_id, cb

