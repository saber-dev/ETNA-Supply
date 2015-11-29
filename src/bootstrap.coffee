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
        # .when '/login', {
        #     templateUrl: 'templates/login.html',
        #     controller:  'loginCtrl',
        # }
        .when '/home',
            templateUrl: 'templates/home.html',
            controller:  'homeCtrl'
        .when '/stock',
            templateUrl: 'templates/stock.html',
            controller:  'stockCtrl'
        .when '/Demandes',
            templateUrl: 'templates/checkDemandes.html',
            controller:  'allDmdsCtrl'
        .otherwise { redirectTo: '/home' }
# .run ($rootScope, AuthentificationService, $location, $cookies) ->
#     if AuthentificationService.checkCookies()
#         $location.path '/home'
#     else
#         $location.path '/login'
