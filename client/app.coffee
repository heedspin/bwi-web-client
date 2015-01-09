"use strict"
#
# vxa =
#   one:1
#   one: 2
app = angular.module("bwi-web-client", [
  "ngRoute"
]).config(($routeProvider) ->

  $routeProvider
    .when "/",
      templateUrl:         "main/main.html"
      controller:          "MainCtrl"
    .otherwise redirectTo: "/"
)
