supply
.controller "homeCtrl", ($scope, $mdDialog, $http) ->
    $scope.hello              = "hello"
    $scope.globalNumberClient = null
    $scope.informatonData     = null
    $scope.fakeData           = null

    $http
      type: "GET"
      url: options.api.base_url + '/userLists'
    .success (data) ->
      $scope.fakeData = data
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
