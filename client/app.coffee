"use strict"

app = angular.module("bwi-web-client", [
  "ngRoute"
]).config(($routeProvider) ->

  $routeProvider
    .when "/",
      templateUrl:         "main/main.html"
      controller:          "MainCtrl"
    .otherwise redirectTo: "/"
)
