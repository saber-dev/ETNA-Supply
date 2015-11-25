supply
.controller "homeCtrl", ($scope) ->
    $scope.hello = "hello"

    $scope.fakeData = [{
      title: "cable Ethernet"
      description: "Cable ethernet de couleur blanche"
      start: "24/10/2015"
      end:   "24/11/2015"
    }, {
      title: "cable Ethernet"
      description: "Cable ethernet de couleur noir"
      start: "24/10/2015"
      end:   "24/11/2015"
    }, {
      title: "cable thunderbolt"
      description: "Thunderbold de couleur blanche"
      start: "24/10/2015"
      end:   "24/11/2015"
    }, {
      title: " clé usb"
      description: "Clé usb a rayure bleu/noir"
      start: "24/10/2015"
      end:   "24/11/2015"
    }, {
      title: " écouteurs"
      description: "écouteurs de couleur blanches"
      start: "24/10/2015"
      end:   "24/11/2015"
    }, {
      title: "tournevis"
      description: "tournevis étoile de couleur noir"
      start: "24/10/2015"
      end:   "24/11/2015"
    }, {
      title: "cable USB"
      description: "cable usb de couleur Noire/bleue"
      start: "24/10/2015"
      end:   "24/11/2015"
    }]

    $scope.test = () ->
        console.log "hey !"
