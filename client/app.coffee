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
    ).state("elected-official",
      templateUrl:         "elected-official/elected-official.html"
      url:                 "/elected-official"
      controller:          "ElectedOfficialCtrl"
    ).state("elected-official.pac",
      templateUrl:         "elected-official/pac/pac.html"
      url:                 "/pac"
      controller:          "PacCtrl"
    ).state("elected-official.party",
      templateUrl:         "elected-official/party/party.html"
      url:                 "/party"
      controller:          "PartyCtrl"
    ).state("elected-official.individual",
      templateUrl:         "elected-official/individual/individual.html"
      url:                 "/individual"
      controller:          "IndividualCtrl"
    ).state("pac",
      templateUrl:         "organization/organization.html"
      url:                 "/pac"
      controller:          "OrganizationCtrl"
    ).state("pac.receipts",
      templateUrl:         "organization/receipts/receipts.html"
      url:                 "/receipts"
      controller:          "ReceiptsCtrl"
    ).state("pac.expenditures",
      templateUrl:         "organization/receipts/receipts.html"
      url:                 "/expenditures"
      controller:          "ExpendituresCtrl"
    ).state("party",
      templateUrl:         "organization/organization.html"
      url:                 "/party"
      controller:          "OrganizationCtrl"
    ).state("party.receipts",
      templateUrl:         "organization/receipts/receipts.html"
      url:                 "/receipts"
      controller:          "ReceiptsCtrl"
    ).state("party.expenditures",
      templateUrl:         "organization/receipts/receipts.html"
      url:                 "/expenditures"
      controller:          "ExpendituresCtrl"
    )

  $urlRouterProvider.otherwise "/"
])
.run ($rootScope, $state) ->
  $rootScope.$state = $state

