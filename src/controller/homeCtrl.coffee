supply
.controller "homeCtrl", ($scope) ->
    $scope.hello = "hello"

    $scope.fakeData = [{
      name: "Mahefa"
    }, {
      name: "Saber"
    }, {
      name: "Sofiane"
    }, {
      name: "Sam"
    }, {
      name: "tes1"
    }, {
      name: "test2"
    }, {
      name: "test3"
    }]

    $scope.test = () ->
        console.log "hey !"
