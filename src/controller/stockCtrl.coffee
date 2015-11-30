supply
.controller "stockCtrl", ($scope, $mdDialog, $http) ->
    # $scope.helloTest = (name) ->
    #   return "hello nigga " + name

    # $scope.message = (name) ->
    #   message = null
    #   $http
    #       method: "GET"
    #       url:    options.api.base_url + "/countList/" + name
    #   .success (data) ->
    #       message = data

    # $scope.dataCount = (name, quantity) ->
    #     test = null
    #     countAvailableItem(name)
        # promise
        # .then (data) ->
        #     data.data = test
        # .catch (err) ->
        #     console.log err
        # return test


    getStock = () ->
      $http
          methode: "GET"
          url:     options.api.base_url + "/materials"
      .success (data) ->
          $scope.datas_material = data
          test = null
          for name in data
              promise = countAvailableItem(name.name)
              promise
              .then (data) ->
                  name.name     = "toto"
                  name.quantity = (parseInt(name.quantity) - parseInt(data.data.count))
          console.log $scope.datas_material
      .error (err) ->
          console.log err


    $scope.infoData = null
    getStock()

    countAvailableItem = (itemName) ->
        $http
            method: "GET"
            url:    options.api.base_url + '/countList/' + itemName

    $scope.getThisMaterial = ($event, data) ->
        console.log data
        $scope.infoData = data
        parent = angular.element document.body
        $mdDialog.show
            parent : parent
            targetEvent : $event
            templateUrl : 'modal/materialModal.html'
            scope : $scope
            preserveScope: true

    $scope.addMaterialStock = ($event) ->
        parent = angular.element document.body
        $mdDialog.show
            parent:        parent
            targetEvent:   $event
            templateUrl:   'modal/addStockModal.html'
            scope:         $scope
            preserveScope: true

    $scope.commit = (data) ->
        $http
            method: "POST"
            url:    options.api.base_url + "/materials"
            data: data
        .success (data) ->
            console.log "done !"
            $mdDialog.hide()
        .error (err) ->
            console.log "nope !"
