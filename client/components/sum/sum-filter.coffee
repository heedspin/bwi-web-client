app.filter "sumOfValue", ->
  (data, key) ->
    return 0  if typeof (data) is "undefined" and typeof (key) is "undefined"
    sum = 0
    i = 0

    while i < data.length
      sum = sum + data[i][key]
      i++
    sum
