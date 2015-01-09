'use strict'

angular.module('bwi-web-client')
  .directive 'clickOff', ($document) ->
    restrict: "A"
    link: (scope, element, attributes) ->
      justOpened = false

      element.bind 'click', (e) ->
        justOpened = true

      $document.bind 'click', ->
        if !justOpened
          scope.$apply(attributes.clickOff)
        justOpened = false
