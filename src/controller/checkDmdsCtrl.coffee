supply
.controller "allDmsCtrl",($scope, $http) ->
  $scope.datas = null

  $http
    type: "GET"
    url: "../json/fakeData.json"
  .success (data) ->
    $scope.datas = data
