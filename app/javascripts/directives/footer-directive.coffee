'use strict'

angular.module('bwi-web-client')
  .directive('bwiFooter', ->
    templateUrl: 'templates/directives/footer.html'
    controller: 'FooterCtrl'
    restrict: 'E'
    replace: true
  )
