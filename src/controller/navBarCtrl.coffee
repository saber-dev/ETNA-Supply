supply
.controller 'navBarCtrl', ($scope, $http, $mdDialog, $mdSidenav, $timeout, SweetAlert, $location) ->
    # getListUSerMaterial = () ->
    #   $http
    #     method: "GET"
    #     url: options.api.base_url + '/materials'
    #   .success (data) ->
    #     console.log data
    #   .error (err) ->
    #     console.log err

    addListMaterial = (date, data) ->
      data.status = "En Attente"
      data.idUser = "123"
      data.idMaterial = "123"
      data.isAccepted = false
      data.isWaiting  = true
      if not data.isOneDay
        data.isOneDay = false
      if not data.isOneWeek
        data.isOneWeek = false
      if not data.isOther
        data.isOther = false
      todayDate = new Date()
      $http
        method: "POST"
        url:  options.api.base_url + '/userLists'
        data:
          itemName:   data.stock
          idUser:     data.idUser
          idMaterial: data.idMaterial
          dateStart:  todayDate
          dateEnd:    "toto"
          status:     data.status
          isAccepted: data.isAccepted
          isWaiting:  data.isWaiting
          isOneDay:   data.isOneDay
          isOneWeek:  data.isOneWeek
          isOther:    data.isOther
      .success (data) ->
          # getListUSerMaterial()
          $mdDialog.hide()
          SweetAlert.swal
              title: "Demende d'emprunt enregistré"
              text:  "Votre demande à bien été pris en compte, vous allez recevoir un mail de confirmation"
              type:  "success"
      .error (err) ->
          SweetAlert.swal
              title: "Impossible de faire la demande"
              text:  "impossible de faire la demande pour le moment"
              type:  "error"

    # getListUSerMaterial()

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

    $scope.checkStock = () ->
        $location.path "/stock"
        $mdSidenav('left').close();
    $scope.lend = () ->
        $location.path "/home"
        $mdSidenav('left').close();
    $scope.checkDemandes = () ->
        $location.path "/Demandes"
        $mdSidenav('left').close();

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
      }, {
        onglet: 'Les Demandes'
#        svg:    'logout.svg'
        function: '$scope.checkDemandes()'
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

    $scope.add = ($event) ->
        console.log "hello"
        parent = angular.element document.body
        $mdDialog.show
            parent:        parent
            targetEvent:   $event
            templateUrl:   'modal/addModal.html'
            scope:         $scope
            preserveScope: true

    $scope.commit = (data) ->
      console.log data
      # Fake data
      date = new Date()
      numberToAdd = null
      if data.isOneDay
        numberToAdd = 1
      if data.isOneWeek
        numberToAdd = 7
      date.setDate(date.getDate() + numberToAdd)
      dd = date.getDate()
      mm = date.getMonth()
      y  = date.getFullYear()
      formattedDate = dd + '/' + mm + '/' + y
      addListMaterial(date, data)


    $scope.getStock = [{
        name: "tournevis"
    }, {
        name: "thunderbold"
    }, {
        name: "ethernet"
    }, {
        name: "rasbery pi"
    }]
