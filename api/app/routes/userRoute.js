var User = require('../models/user');

module.exports = function(router) {

    router.route('/Users')
        .post(function(req, res) {
            var user      = new User();
            user.login    = req.body.login;
            user.password = req.body.password;
            user.role     = req.body.role;

            user.save(function(err) {
                if (err)
                    res.send(err);
                res.json({ message: 'User created'});
            });
        })

        .get(function(req, res) {
            User.find(function(err, role) {
                if (err)
                  res.send(err);
                res.json(role);
            });
        });

    router.route('/Users/:user_id')
        .get(function(req, res) {
            User.findById(req.params.user_id, function(err, user){
                if (err)
                    res.send(err);
                res.json(user);
            });
        })

        .put(function(req, res){
            User.findById(req.params.user_id, function(err, user){
                if (err)
                    res.send(err);

                user.login     = req.body.login;
                user.password  = req.body.password;
                user.roles     = req.body.roles;

                user.save(function(err) {
                  if (err)
                      res.send(err);
                  res.json({ message: 'user Updated!'});
                });
            });
        })

        .delete(function(req, res) {
          Material.remove({
              _id: req.params.user_id
          }, function(err, user) {
              if (err)
                  res.send(err);
              res.json({ message: "user successfully deleted "});
          });
        });
}
