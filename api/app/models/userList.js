var mongoose = require('mongoose');
var Schema   = mongoose.Schema;

var userListSchema = new Schema({
    login:      String,
    itemName:   String,
    idUser:     String,
    idMaterial: String,
    dateStart:  String,
    dateEnd:    String,
    status:     String,
    isAccepted: Boolean,
    isWaiting:  Boolean,
    isOneDay:   Boolean,
    isOneWeek:  Boolean,
    isOther:    Boolean
});

module.exports = mongoose.model('UserList', userListSchema);
