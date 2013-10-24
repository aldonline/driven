###
returns a google drive file object
with an extra __html property
which does not contain the HTML text
but rather an object with several properties
###
module.exports = ( id, cb ) ->
  fetch_doc id, ( e, r ) ->
    if r.exportLinks?
      require('./html/get') r, (err, html) ->
        r.__html = html
        cb e, r
    else
      cb e, r

fetch_doc = ( id, cb ) ->
  require('./drive_api_req')
    req: (client) -> client.drive.files.get fileId: id
    cb: cb