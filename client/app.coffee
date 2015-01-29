"use strict"
#
# vxa =
#   one:1
#   one: 2

app = angular.module("bwi-web-client", [
  "ui.router"
  "ui.select"
  "ngSanitize"
  "ngTable"
  "ngCookies"
])
.config(['$stateProvider','$urlRouterProvider', 'uiSelectConfig', '$httpProvider',
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
    ).state("elected-official",
      templateUrl:         "elected-official/elected-official.html"
      url:                 "/elected-official"
      controller:          "ElectedOfficialCtrl"
    ).state("elected-official.pac",
      templateUrl:         "elected-official/pac/pac.html"
      url:                 "/pac"
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
      controller:          "OrganizationCtrl"
    ).state("pac.expenditures",
      templateUrl:         "organization/expenditures/expenditures.html"
      url:                 "/expenditures"
      controller:          "OrganizationCtrl"
    ).state("party",
      templateUrl:         "organization/organization.html"
      url:                 "/party"
      controller:          "OrganizationCtrl"
    ).state("party.receipts",
      templateUrl:         "organization/receipts/receipts.html"
      url:                 "/receipts"
      controller:          "OrganizationCtrl"
    ).state("party.expenditures",
      templateUrl:         "organization/expenditures/expenditures.html"
      url:                 "/expenditures"
      controller:          "OrganizationCtrl"
    )

  $urlRouterProvider.otherwise "/"

  uiSelectConfig.theme = 'selectize'

])

.constant "bwiConfig",
  BASE_URL: "https://stagingapi.bellwetherinsights.com"
  API_URL: "https://stagingapi.bellwetherinsights.com/api/v1"

.run ($rootScope, $state, $cookieStore, $http, Auth) ->
  $rootScope.$state = $state
  $http.defaults.headers.common["BWI_AUTH_TOKEN"] = $cookieStore.get "BWI_AUTH_TOKEN"

