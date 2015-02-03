app.filter 'unique', ->
  (items, filterOn) ->
    if filterOn == false
      return items
    if (filterOn or angular.isUndefined(filterOn)) and angular.isArray(items)
      hashCheck = {}
      newItems = []

      extractValueToCompare = (item) ->
        if angular.isObject(item) and angular.isString(filterOn)
          item[filterOn]
        else
          item

      angular.forEach items, (item) ->
        valueToCheck = undefined
        isDuplicate = false
        i = 0
        while i < newItems.length
          if angular.equals(extractValueToCompare(newItems[i]), extractValueToCompare(item))
            isDuplicate = true
            break
          i++
        if !isDuplicate
          newItems.push item
        return
      items = newItems
    items
