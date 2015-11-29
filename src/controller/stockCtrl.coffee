supply
.controller "stockCtrl", ($scope, $mdDialog, $http) ->
    getStock = () ->
      $http
          methode: "GET"
          url:     options.api.base_url + "/materials"
      .success (data) ->
          $scope.datas_material = data
      .error (err) ->
          console.log err


    $scope.infoData = null
    getStock()

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
