'user strict'

angular.module('bwi-web-client')
.factory "Party", ($q, $http, bwiConfig) ->

  aggregatePartyData = (collection)->
    aggregateCollection = []

    for item in collection
      party = item.party

      existing = _.where aggregateCollection,
        id: party.id

      if not existing.length
        aggregateCollection.push
          id: party.id
          amount: item.amount
          party: party

      if existing.length is 1
        existing[0].amount += item.amount

    aggregateCollection

  get: (params) ->
    deferred = $q.defer()

    requestParams = {}

    if params.type[0] is 'elected-official'
      params.type[0] = 'elected_officials'

    if params.startYear
      requestParams.start_date = params.startYear + '-01-01'

    if params.endYear
      requestParams.end_date = params.endYear + '-12-31'

    requestUrl = "#{bwiConfig.API_URL}/#{params.type[0]}/#{params.id}/receipts_from_parties"

    if requestParams.start_date || requestParams.end_date
      requestUrl += ('?' + jQuery.param requestParams)

    $http.get requestUrl
    .then (response) ->
      data = response.data.receipts_from_parties
      cumulativeData = aggregatePartyData data

      deferred.resolve
        cumulative: cumulativeData
        individual: data

    deferred.promise
