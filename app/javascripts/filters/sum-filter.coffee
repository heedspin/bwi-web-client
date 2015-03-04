app.filter "sumOfValue", ->
  (data, key) ->
    if (typeof(data) is "undefined") or (typeof(key) is "undefined")
      return 0

    sum = 0
    i = 0

    while i < data.length
      sum = sum + data[i][key]
      i++
    sum
