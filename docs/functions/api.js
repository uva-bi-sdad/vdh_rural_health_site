'use strict'
const DataHandler = require('../data_handler.v1.min.js'),
  data = new DataHandler(require('../settings.json'), void 0, {
    tract: require('../tract.json'),
    county: require('../county.json'),
    district: require('../district.json'),
  })
module.exports.handler = async function (event) {
  return data.export(event.queryStringParameters)
}
