'use strict'

angular.module('bwi-web-client')
  .directive('bwiTable', ->
    templateUrl: 'components/table/table.html'
    restrict: 'E'
    scope:
      options: "="
      filterText: "="
  )
