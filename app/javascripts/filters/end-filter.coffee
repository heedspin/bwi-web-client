'use strict'

angular.module('bwi-web-client')
.filter 'endYear', ->
  (items, endYear) ->
    if !endYear
      return items

    filtered = []
    endYear = new Date(endYear, 12, 31)
    for item in items
      itemDate = new Date(item.date)
      if itemDate < endYear
        filtered.push item

    filtered
