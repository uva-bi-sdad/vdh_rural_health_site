'use strict'
const DataHandler = require('../docs/data_handler.js').
  data = new DataHandler(require('../docs/settings.json'))
module.export.handler = async function(event){
  return data.export(event.queryStringParameters)
}



