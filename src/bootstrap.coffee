'use strict'

supply = angular.module 'supply', [
  'ngRoute'
  'ngMaterial'
  'ngCookies'
  'oitozero.ngSweetAlert'
  'ngAria'
  'ngSanitize'
  'md.data.table'
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
        .otherwise { redirectTo: '/home' }
