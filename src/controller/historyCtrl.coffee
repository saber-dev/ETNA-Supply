supply
.controller "historyCtrl", ($scope, $http) ->
    $scope.history = null

    getHistory = () ->
      $http
          method: "GET"
          url:    options.api.base_url + "/historyList"
      .success (data) ->
          console.log data
          $scope.history = data

    getHistory()
