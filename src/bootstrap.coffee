'use strict'

supply = angular.module 'supply', [
  'ngRoute'
  'ngMaterial'
  'ngCookies'
  'oitozero.ngSweetAlert'
  'ngAria'
  'ngSanitize'
  'md.data.table'
  'angular-md5'
]

options = {}
options.api = {}
options.api.base_url = 'http://localhost:3000/api'

supply
.config ($routeProvider, $httpProvider, $locationProvider, $cookiesProvider) ->
    $routeProvider
        .when '/home',
            templateUrl: 'templates/home.html',
            controller:  'homeCtrl'
        .when '/stock',
            templateUrl: 'templates/stock.html',
            controller:  'stockCtrl'
        .when '/demande',
            templateUrl: 'templates/askMaterial.html',
            controller:  'askMaterialCtrl'
        .when '/historique',
            templateUrl: 'templates/history.html',
            controller:  'historyCtrl'
        .when '/login',
            templateUrl: 'templates/foo.html',
            controller:  'loginCtrl'
        .otherwise { redirectTo: '/login' }
.run ($rootScope, AuthentificationService, $location, $cookies) ->
    if AuthentificationService.checkCookies()
        $location.path '/home'
    else
        $location.path '/login'
