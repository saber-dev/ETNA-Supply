var UserList = require('../models/userList');

module.exports = function(router) {

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
                res.json({ message: 'List created'});
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
            UserList.findById(req.params.list_id, function(err, userList){
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
