"use strict";var app;app=angular.module("bwi-web-client",["ngRoute"]).config(["$routeProvider",function(e){return e.when("/",{templateUrl:"main/main.html",controller:"MainCtrl"}).otherwise({redirectTo:"/"})}]);
angular.module("bwi-web-client").factory("Settings",function(){return{"default":!0}});
"use strict";angular.module("bwi-web-client").controller("SettingsCtrl",["$scope","Settings",function(){return void 0}]);
"use strict";angular.module("bwi-web-client").controller("MainCtrl",["$scope","Settings",function(){return void 0}]);