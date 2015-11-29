var UserList = require('../models/userList');
var mailer = require('express-mailer');

module.exports = function(router, app) {
    router.route('/userLists')
        .post(function(req, res) {
            var userList        = new UserList();
            userList.itemName   = req.body.itemName;
            userList.idUser     = req.body.idUser;
            userList.idMaterial = req.body.idMaterial;
            userList.dateStart  = req.body.dateStart;
            userList.dateEnd    = req.body.dateEnd;
            userList.status     = req.body.status;
            userList.isAccepted = req.body.isAccepted;
            userList.isWaiting  = req.body.isWaiting;
            userList.isOneDay   = req.body.isOneDay;
            userList.isOneWeek  = req.body.isOneWeek;
            userList.isOther    = req.body.isOther;

            userList.save(function(err) {
                if (err)
                    res.send(err);
                app.mailer.send('email', {
                    to:'nmahefa@gmail.com',
                    subject: "Demande d'emprunt de matériel",
                    dateStart: req.body.dateStart,
                    dateEnd: req.body.dateEnd,
                    itemName: req.body.itemName
                }, function(err) {
                    if (err) {
                      console.log(err)
                      res.send('unable to send mail');
                    }
                    res.json({ message: 'List created'});
                });
            });
        })

        .get(function(req, res) {
            UserList.find(function(err, userList) {
                if (err)
                  res.send(err);
                res.json(userList);
            });
        });

    router.route('/userLists/:list_id')
        .get(function(req, res) {
            UserList.find({ idUser: req.params.list_id }, function(err, userList){
                if (err)
                    res.send(err);
                res.json(userList);
            });
        })

        .put(function(req, res){
            UserList.findById(req.params.list_id, function(err, userList){
                if (err)
                    res.send(err);

                userList.itemName   = req.body.itemName;
                userList.idUser     = req.body.idUser;
                userList.idMaterial = req.body.idMaterial;
                userList.dateStart  = req.body.dateStart;
                userList.dateEnd    = req.body.dateEnd;
                userList.status     = req.body.status;
                userList.isAccepted = req.body.isAccepted;
                userList.isWaiting  = req.body.isWaiting;
                userList.isOneDay   = req.body.isOneDay;
                userList.isOneWeek  = req.body.isOneWeek;
                userList.isOther    = req.body.isOther;

                userList.save(function(err) {
                  if (err)
                      res.send(err);
                  res.json({ message: 'list Updated!'});
                });
            });
        })

        .delete(function(req, res) {
          UserList.remove({
              _id: req.params.list_id
          }, function(err, material) {
              if (err)
                  res.send(err);
              res.json({ message: "list successfully deleted "});
          });
        });
}
