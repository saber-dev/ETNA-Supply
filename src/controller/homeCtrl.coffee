supply
.controller "homeCtrl", ($scope, $mdDialog, $http, SweetAlert, $location) ->

    $scope.hello              = "hello"
    $scope.globalNumberClient = null
    $scope.informatonData     = null
    $scope.fakeData           = null

    getListMaterial = () ->
        $http
          type: "GET"
          url: options.api.base_url + '/userLists/123'
        .success (data) ->
          $scope.fakeData = data
        .error (err) ->
          console.log err

    getListMaterial()

    addListMaterial = (date, data) ->
      data.status = "En Attente"
      data.idUser = "123"
      data.idMaterial = "123"
      data.isAccepted = false
      data.isWaiting  = true
      data.login      = "andria_m"
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
          login:      data.login
          itemName:   data.stock
          idUser:     data.idUser
          idMaterial: data.idMaterial
          dateStart:  todayDate
          dateEnd:    date
          status:     data.status
          isAccepted: data.isAccepted
          isWaiting:  data.isWaiting
          isOneDay:   data.isOneDay
          isOneWeek:  data.isOneWeek
          isOther:    data.isOther
      .success (data) ->
          getListMaterial()
          $mdDialog.hide()
          SweetAlert.swal
              title: "Demande d'emprunt enregistré"
              text:  "Votre demande à bien été pris en compte, vous allez recevoir un mail de confirmation"
              type:  "success"
      .error (err) ->
          SweetAlert.swal
              title: "Impossible de faire la demande"
              text:  "impossible de faire la demande pour le moment"
              type:  "error"

    getStock = () ->
      $http
          methode: "GET"
          url:     options.api.base_url + "/materials"
      .success (data) ->
          for name in data
            $http
                method: "GET"
                url:    options.api.base_url + '/countList/' + name.name
            .success (data) ->
                name.quantity = (parseInt(name.quantity) - parseInt(data))
                console.log name.quantity
            .error (err) ->
                console.log "unable to fetch data"
          $scope.getStock = data
      .error (err) ->
          console.log err

    $scope.getInfo = ($event, data) ->
        # $scope.globalNumberClient = data.id
        $scope.informationData = data
        console.log data
        parent = angular.element document.body
        $mdDialog.show
            parent: parent
            targetEvent: $event
            templateUrl: 'modal/infoModal.html'
            scope:       $scope
            preserveScope: true

    $scope.add = ($event) ->
        getStock()
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

    $scope.deleteOneList = (id) ->
        SweetAlert.swal {
            title: "Annulation d'une demande d'emprunt"
            text:  "Etes vous sur de vouloir annuler la demande ?"
            type:  "warning"
            showCancelButton: true
            confirmButtonColor: "#DD6B55"
            confirmButtonText: "Demander L'annulation"
            cancelButtonText: "Annuler"
            closeOnConfirm: false
            closeOnCancel: true
        }, (isConfirm) ->
          if isConfirm
            $http
                method: 'DELETE'
                url: options.api.base_url + '/userLists/' + id
            .success (success) ->
                getListMaterial()
                SweetAlert.swal
                    title: "Annulation"
                    text:  "Annulation effectué avec succes"
                    type:  "success"
            .error (err) ->
                SweetAlert.swal
                    title: "Annulation impossible"
                    text:  "impossible d'annuler la demande"
                    type:  "error"
