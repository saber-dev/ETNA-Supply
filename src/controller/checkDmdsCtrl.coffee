supply
.controller "allDmdsCtrl",($scope, $http) ->
  $scope.datas = null

  $http
    type: "GET"
    url: "../src/controller/json/fakeData.json"
  .success (data) ->
    $scope.datas = data

