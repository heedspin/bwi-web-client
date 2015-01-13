'use strict'

angular.module('bwi-web-client')
  .directive('bwiFooter', ->
    templateUrl: 'components/footer/footer.html'
    controller: 'FooterCtrl'
    restrict: 'E'
  )
