supply
.controller "askMaterialCtrl",($scope, $http, SweetAlert) ->
  $scope.list = null

  getUserListAsk = () ->
      $http
        method: "GET"
        url: options.api.base_url + "/userListAsk"
      .success (data) ->
        console.log data
        $scope.list = data

  getUserListAsk()

  errorAsk = () ->
      SweetAlert.swal
          title: "Impossible de repondre à la demande"
          text:  "Une erreur est survenue"
          type:  "error"

  $scope.accept = (id) ->
    $http
        method: "PUT"
        url: options.api.base_url + "/userListAsk/" + id
        data:
          status: "Accepté"
          isWaiting: false
          isAccepted: true
    .success (data) ->
        getUserListAsk()
        SweetAlert.swal
            title: "Demande accepté !"
            text:  "Vous avez accepté la demande, l'utilisateur concerné recevra un mail de confirmation"
            type:  "success"
    .error (err) ->
        errorAsk()

  $scope.refuse = (id) ->
    $http
        method: "PUT"
        url:    options.api.base_url + "/userListAsk/" + id
        data:
          status:     "Refusé"
          isWaiting:  false
          isAccepted: false
    .success (data) ->
        getUserListAsk()
        SweetAlert.swal
            title: "Demande refusé !"
            text:  "vous avez refusé la demande, l'utilisateur concerné recevra un mail de confirmation"
            type:  "warning"
    .error (err) ->
        errorAsk()
