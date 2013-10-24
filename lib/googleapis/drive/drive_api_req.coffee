api_req = require '../api_request'

module.exports = ( { req, cb } ) ->
  api_req
    api:     'drive'
    version: 'v2'
    req:     req
    cb:      cb