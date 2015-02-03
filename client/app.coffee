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
      data:                 {requiresLogin: true}
    ).state("elected-official",
      templateUrl:         "elected-official/elected-official.html"
      abstract:            true
      url:                 "/elected-official/:id"
      controller:          "ElectedOfficialCtrl"
      data:                 {requiresLogin: true}
    ).state("elected-official.pac",
      templateUrl:         "elected-official/pac/pac.html"
      url:                 ""
      controller:          "PacCtrl"
      data:                 {requiresLogin: true}
    ).state("elected-official.party",
      templateUrl:         "elected-official/party/party.html"
      url:                 "/party"
      data:                 {requiresLogin: true}
    ).state("elected-official.individual",
      templateUrl:         "elected-official/individual/individual.html"
      url:                 "/individual"
      data:                 {requiresLogin: true}
    ).state("pac",
      templateUrl:         "organization/organization.html"
      url:                 "/pac"
      controller:          "OrganizationCtrl"
      data:                 {requiresLogin: true}
    ).state("pac.receipts",
      templateUrl:         "organization/receipts/receipts.html"
      url:                 "/receipts"
      controller:          "OrganizationCtrl"
      data:                 {requiresLogin: true}
    ).state("pac.expenditures",
      templateUrl:         "organization/expenditures/expenditures.html"
      url:                 "/expenditures"
      controller:          "OrganizationCtrl"
      data:                 {requiresLogin: true}
    ).state("party",
      templateUrl:         "organization/organization.html"
      url:                 "/party"
      controller:          "OrganizationCtrl"
      data:                 {requiresLogin: true}
    ).state("party.receipts",
      templateUrl:         "organization/receipts/receipts.html"
      url:                 "/receipts"
      controller:          "OrganizationCtrl"
      data:                 {requiresLogin: true}
    ).state("party.expenditures",
      templateUrl:         "organization/expenditures/expenditures.html"
      url:                 "/expenditures"
      controller:          "OrganizationCtrl"
      data:                 {requiresLogin: true}
    )

  $urlRouterProvider.otherwise "/"

  uiSelectConfig.theme = 'selectize'

])

.constant "bwiConfig",
  BASE_URL: "https://stagingapi.bellwetherinsights.com"
  API_URL: "https://stagingapi.bellwetherinsights.com/api/v1"

.run ($rootScope, $state, $cookieStore, $http, Auth) ->
  $rootScope.$state = $state
  $http.defaults.headers.common['X-BWI-AUTH-TOKEN'] = $cookieStore.get 'X-BWI-AUTH-TOKEN'

  $rootScope.$on '$stateChangeStart', (e, toState, toParams, fromState, fromParams) ->
    isAuthenticationRequired = toState.data and toState.data.requiresLogin and not Auth.isLoggedIn()

    if isAuthenticationRequired
      $state.go "login"
      e.preventDefault()
