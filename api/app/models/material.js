var mongoose = require('mongoose');
var Schema   = mongoose.Schema;

var materialSchema = new Schema({
    name:       String,
    quantity:   Number,
    dateStart : String,
    dateEnd:    String
});

module.exports = mongoose.model('Material', materialSchema);
