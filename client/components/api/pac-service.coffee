'user strict'

angular.module('bwi-web-client')
.factory "Pac", ($q, $http) ->

  aggregatePacData = (collection)->
    aggregateCollection = []

    for item in collection
      pac = item.pac

      existing = _.where aggregateCollection,
        id: pac.id

      if not existing.length
        aggregateCollection.push
          id: pac.id
          amount: item.amount
          pac: pac

      if existing.length is 1
        existing[0].amount += item.amount

    aggregateCollection

  get: (url, startDate, endDate) ->
    deferred = $q.defer()

    $http.get "#{url}/receipts_from_pacs"
    .then (response) ->
      data = response.data.receipts_from_pacs
      cumulativeData = aggregatePacData data

      deferred.resolve
        cumulative: cumulativeData
        individual: data

    deferred.promise
