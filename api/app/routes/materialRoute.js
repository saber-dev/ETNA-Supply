var Material = require('../models/material');
var UserList = require('../models/userList');

module.exports = function(router) {

    router.route('/materials')
        .post(function(req, res) {
            var material       = new Material();
            material.name      = req.body.name;
            material.quantity  = req.body.quantity;
            material.dateStart = "nope";
            material.dateEnd   = "nope";

            material.save(function(err) {
                if (err)
                    res.send(err);
                res.json({ message: 'Material created'});
            });
        })

        .get(function(req, res) {
            Material.find(function(err, materials) {
                if (err)
                  res.send(err);
                res.json(materials);
            });
        });

    router.route('/materials/:material_id')
        .get(function(req, res) {
            Material.findById(req.params.material_id, function(err, material){
                if (err)
                    res.send(err);
                res.json(material);
            });
        })

        .put(function(req, res){
            Material.findById(req.params.material_id, function(err, material){
                if (err)
                    res.send(err);

                material.name      = req.body.name;
                material.quantity  = req.body.quantity;
                material.dateStart = "modify nope!";
                material.dateEnd   = "modify nope!";

                material.save(function(err) {
                  if (err)
                      res.send(err);
                  res.json({ message: 'Material Updated!'});
                });
            });
        })

        .delete(function(req, res) {
          Material.remove({
              _id: req.params.material_id
          }, function(err, material) {
              if (err)
                  res.send(err);
              res.json({ message: "successfully deleted "});
          });
        });
}
