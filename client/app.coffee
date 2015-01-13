"use strict"
#
# vxa =
#   one:1
#   one: 2

app = angular.module("bwi-web-client", [
  "ui.router"
])
.config(['$stateProvider','$urlRouterProvider'
($stateProvider, $urlRouterProvider) ->

  $stateProvider
    .state("login",
      templateUrl:         "login/login.html"
      url:                 "/"
      controller:          "LoginCtrl"
    ).state "main",
      templateUrl:         "main/main.html"
      url:                 "/main"
      controller:          "MainCtrl"
  $urlRouterProvider.otherwise "/"
])
