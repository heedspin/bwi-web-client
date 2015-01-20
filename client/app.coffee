"use strict"
#
# vxa =
#   one:1
#   one: 2

app = angular.module("bwi-web-client", [
  "ui.router"
  "ui.select"
  "ngSanitize"
])
.config(['$stateProvider','$urlRouterProvider', 'uiSelectConfig',
($stateProvider, $urlRouterProvider, uiSelectConfig) ->

  $stateProvider
    .state("login",
      templateUrl:         "login/login.html"
      url:                 "/"
      controller:          "LoginCtrl"
    ).state("search",
      templateUrl:         "search/search.html"
      url:                 "/search"
      controller:           "SearchCtrl"
    ).state "index",
      templateUrl:         "index/index.html"
      url:                 "/index"
      controller:          "IndexCtrl"
  $urlRouterProvider.otherwise "/"

  uiSelectConfig.theme = "bootstrap"
  uiSelectConfig.resetSearchInput = true

])
.run ($rootScope, $state) ->
  $rootScope.$state = $state

