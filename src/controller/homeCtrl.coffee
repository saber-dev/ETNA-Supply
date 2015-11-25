supply
.controller "homeCtrl", ($scope) ->
    $scope.hello = "hello"

    $scope.fakeData = [{
      title: "j'ai pris un cable Ethernet"
      description: "Cable ethernet de couleur blanche"
      start: "24/10/2015"
      end:   "24/11/2015"
    }, {
      title: "j'ai pris un cable Ethernet"
      description: "Cable ethernet de couleur noir"
      start: "24/10/2015"
      end:   "24/11/2015"
    }, {
      title: "j'ai pris un cable thunderbolt"
      description: "Thunderbold de couleur blanche"
      start: "24/10/2015"
      end:   "24/11/2015"
    }, {
      title: "j'ai pris une clé usb"
      description: "Clé usb a rayure bleu/noir"
      start: "24/10/2015"
      end:   "24/11/2015"
    }, {
      title: "j'ai pris des écouteurs"
      description: "écouteurs de couleur blanches"
      start: "24/10/2015"
      end:   "24/11/2015"
    }, {
      title: "j'ai pris un tournevis"
      description: "tournevis étoile de couleur noir"
      start: "24/10/2015"
      end:   "24/11/2015"
    }, {
      title: "j'ai pris un cable USB"
      description: "cable usb de couleur Noire/bleue"
      start: "24/10/2015"
      end:   "24/11/2015"
    }]

    $scope.test = () ->
        console.log "hey !"
