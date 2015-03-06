'use strict'

angular.module('bwi-web-client')
  .directive('bwiFooter', ->
    templateUrl: 'directives/footer.html'
    controller: 'FooterCtrl'
    restrict: 'E'
    replace: true
  )
