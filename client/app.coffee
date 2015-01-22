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
    ).state("entities",
      templateUrl:         "entities/entities.html"
      url:                 "/entities"
      controller:          "EntitiesCtrl"
    ).state("entities.pac",
      templateUrl:         "pac/pac.html"
      url:                 "/pac/:id/"
      controller:          "PacCtrl"
    ).state("entities.pac.expenditures",
      templateUrl:         "expenditures/expenditures.html"
      url:                 "expenditures"
      controller:          "ExpendituresCtrl"
    ).state("entities.pac.receipts",
      templateUrl:         "receipts/receipts.html"
      url:                 "receipts"
      controller:          "ReceiptsCtrl"
    ).state("entities.party",
      templateUrl:         "party/party.html"
      url:                 "/party/:id/"
      controller:          "PartyCtrl"
    ).state("entities.party.expenditures",
      templateUrl:         "expenditures/expenditures.html"
      url:                 "expenditures"
      controller:          "ExpendituresCtrl"
    ).state("entities.individual",
      templateUrl:         "individual/individual.html"
      url:                 "/individual"
      controller:          "IndividualCtrl"
    )
  $urlRouterProvider.otherwise "/"
])
.run ($rootScope, $state) ->
  $rootScope.$state = $state

