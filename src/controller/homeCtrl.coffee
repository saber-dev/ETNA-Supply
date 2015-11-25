supply
.controller 'homeCtrl', ($scope, $http, $mdDialog, $mdSidenav, $timeout, SweetAlert) ->
    # $scope.name = $cookies.get md5.createHash('user')
    # $scope.role = checkRole.findRole $cookies.get md5.createHash('role')
    $scope.test = () ->
        console.log "toto"

    $scope.fakeData = [{
        onglet:   'Mes emprunts'
        svg:      'lend.svg'
        function: 'lend'
        id: 1
      }, {
        onglet: 'Stock'
        svg:    'stock.svg'
        function: 'stock'
        id: 2
      }, {
        onglet: 'échéances'
        svg:    'echeances.svg'
        id: 3
        function: 'echeances'
      }, {
        onglet: 'deconnexion'
        svg:    'logout.svg'
        function: '$scope.logout()'
        id: 4
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
          $log.debug "toggle " + navID + " is done"
      ), 200)

    $scope.toggleLeft = buildDelayedToggler('left')
