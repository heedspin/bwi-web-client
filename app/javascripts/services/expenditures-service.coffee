'user strict'

angular.module('bwi-web-client')
.factory "Expenditures", ($q, $http, bwiConfig) ->

  aggregateExpendituresData = (collection)->
    aggregateCollection = []

    for item in collection
      elected_official = item.elected_official

      existing = _.where aggregateCollection,
        id: elected_official.id

      if not existing.length
        aggregateCollection.push
          id: elected_official.id
          amount: item.amount
          elected_official: elected_official

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

    requestUrl = "#{bwiConfig.API_URL}/#{params.type[0]}/#{params.id}/expenditures"

    if requestParams.start_date || requestParams.end_date
      requestUrl += ('?' + jQuery.param requestParams)

    $http.get requestUrl
    .then (response) ->
      data = response.data[params.type[1]]
      cumulativeData = aggregateExpendituresData data

      deferred.resolve
        cumulative: cumulativeData
        individual: data

    deferred.promise
