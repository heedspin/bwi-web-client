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
    ).state("search",
      templateUrl:         "search/search.html"
      url:                 "/search"
      controller:           "SearchCtrl"
    ).state("index",
      templateUrl:         "index/index.html"
      url:                 "/index"
      controller:          "IndexCtrl"
    ).state("index.expenditures",
      templateUrl:         "/components/expenditures/expenditures.html"
      url:                 "/expenditures"
      controller:          "ExpendituresCtrl"
    ).state "index.receipts",
      templateUrl:         "/components/receipts/receipts.html"
      url:                 "/receipts"
      controller:          "ReceiptsCtrl"

  $urlRouterProvider.otherwise "/"
])
.run ($rootScope, $state) ->
  $rootScope.$state = $state

