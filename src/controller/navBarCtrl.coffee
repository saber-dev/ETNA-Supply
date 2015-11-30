supply
.controller 'navBarCtrl', ($scope, $http, $mdDialog, $mdSidenav, $timeout, SweetAlert, $location) ->

    $scope.loginPage = $location.path() == '/login'

    $scope.checkAction = (name) ->
        if name == "deconnexion"
            $scope.logout()
        if name == "Mes emprunts"
            $scope.lend()
        if name == "Stock"
            $scope.checkStock()
        if name == "Les Demandes"
            $scope.checkDemandes()
        if name == "échéances"
            $scope.checkEcheances()
        if name == "Historique"
            $scope.checkHistory()

    $scope.checkStock = () ->
        $location.path "/stock"
        $mdSidenav('left').close();
    $scope.lend = () ->
        $location.path "/home"
        $mdSidenav('left').close();
    $scope.checkDemandes = () ->
        $location.path "/demande"
        $mdSidenav('left').close();
    $scope.checkHistory = () ->
        $location.path "/historique"
        $mdSidenav('left').close()

    $scope.fakeData = [{
        onglet:   'Mes emprunts'
        svg:      'lend.svg'
        id: 1
      }, {
        onglet: 'Stock'
        svg:    'stock.svg'
        function: 'stock'
        id: 2
      }, {
        onglet:   'Les Demandes'
        svg:      'echeances.svg'
        id: 3
      }, {
        onglet: 'Historique'
        svg:    'history.svg'
        id: 4
      }, {
        onglet: 'deconnexion'
        svg:    'logout.svg'
        id: 5
      }]

    $scope.logout = () ->
        SweetAlert.swal {
              title: "Deconnexion"
              text:  "Ceci mettra fin à votre session, continuer ?"
              type:  "warning"
              showCancelButton: true
              confirmButtonColor: "#DD6B55"
              confirmButtonText: "Deconnexion"
              cancelButtonText: "Annuler"
              closeOnConfirm: true
              closeOnCancel: true
          }, (isConfirm) ->
            if isConfirm
              console.log "done !"
            else
              console.log "nope !"
    debounce = (func, wait, context) ->
      timer = undefined

      debounced = () ->
        context = $scope
        args    = Array.prototype.slice.call arguments
        $timeout.cancel timer
        timer = $timeout(( ->
          timer = 0
          func.apply context, args
        ),wait || 10)

    buildDelayedToggler = (navID) ->
      debounce(( ->
        $mdSidenav(navID)
        .toggle()
        .then ->
          console.log "toggle " + navID + " is done"
      ), 200)

    $scope.toggleLeft = buildDelayedToggler('left')
