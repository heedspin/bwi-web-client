'user strict'

angular.module('bwi-web-client')
.factory "Pac", ($q, $http, bwiConfig) ->

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

  get: (params) ->
    deferred = $q.defer()

    requestParams = {}

    if params.startYear
      requestParams.start_date = params.startYear + '-01-01'

    if params.endYear
      requestParams.end_date = params.endYear + '-12-31'

    requestUrl = "#{bwiConfig.API_URL}/elected_officials/#{params.id}/receipts_from_pacs"

    if requestParams.start_date || requestParams.end_date
      requestUrl += ('?' + jQuery.param requestParams)

    $http.get requestUrl
    .then (response) ->
      data = response.data.receipts_from_pacs
      cumulativeData = aggregatePacData data

      deferred.resolve
        cumulative: cumulativeData
        individual: data

    deferred.promise
