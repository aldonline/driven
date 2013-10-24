googleapis = require 'googleapis'
config     = require('../config').googleapis

module.exports = -> new googleapis.OAuth2Client config.client_id(), config.client_secret(), config.redirect_url()