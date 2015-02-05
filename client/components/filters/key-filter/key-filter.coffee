'use strict'

angular.module('bwi-web-client')
.filter 'keyFilter', ->
  (items, keyName, keyValue) ->
    if !keyName or !keyValue
      return items

    filtered = []

    for item in items
      data = item

      for key in keyName.split '.'
        data = data[key]

      # stringify the property
      data = data + ''

      # to lower it
      data = data.toLowerCase()

      # to lower search query
      keyValue = keyValue.toLowerCase()

      if data.indexOf(keyValue) > -1
        filtered.push item

    filtered
