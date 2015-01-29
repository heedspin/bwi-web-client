'use strict'

angular.module('bwi-web-client')
.filter 'startYear', ->
  (items, startYear) ->

    if !startYear
      return items

    filtered = []
    startYear = new Date(startYear, 1, 1)

    for item in items
      itemDate = new Date(item.date)
      if itemDate > startYear
        filtered.push item
        console.log itemDate

    filtered
