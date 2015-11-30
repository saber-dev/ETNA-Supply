supply
.controller "loginCtrl", ($scope, $mdDialog, $location, AuthentificationService, UserService) ->

    if AuthentificationService.checkCookies()
      $location.path '/home'

    $scope.signIn = (formData) ->
      # console.log formData.username
      if formData.username and formData.password
          UserService.logIn(formData.username, formData.password)
          .success (data) ->
              console.log data
              promise = AuthentificationService.insertCookies(data[0].login, data[0].roles)
              promise
              .then (data) ->
                  $mdDialog.hide()
                  $location.path '/home'
              .catch (err) ->
                  console.log ("error")
              $location.path '/home'
          .error (err) ->
              SweetAlert.swal
                  title: "Access Refusé"
                  text:  "Login ou Mot de passe invalide, veuillez vous reconnecter"
                  type:  "error"

    $scope.Login = () ->
        $mdDialog.hide()

    parent = angular.element document.body
    $mdDialog.show
        templateUrl:         'templates/login.html'
        scope:               $scope
        preserveScope:       true
        clickOutsideToClose: false
        disableParentScroll: true
        escapeToClose:       false
