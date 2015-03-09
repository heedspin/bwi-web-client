'user strict'

angular.module('bwi-web-client')
.factory "Pac", ($q, $http, $cookieStore, $window, bwiConfig) ->

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

  urlFor = (params, format) ->
    if params.type[0] is 'elected-official'
      params.type[0] = 'elected_officials'

    requestUrl = "#{bwiConfig.API_URL}/#{params.type[0]}/#{params.id}/receipts_from_pacs"

    requestParams =
      start_year: params.yearFilters.startYear
      end_year: params.yearFilters.endYear
      start_quarter: params.yearFilters.startQuarter
      end_quarter: params.yearFilters.endQuarter

    if format
      requestUrl += ".#{format}"
      requestParams.BWI_AUTH_TOKEN = $cookieStore.get('X-BWI-AUTH-TOKEN')

    requestUrl += ('?' + jQuery.param requestParams)

  get: (params) ->
    deferred = $q.defer()

    $http.get urlFor(params)
    .then (response) ->
      data = response.data.receipts_from_pacs
      cumulativeData = aggregatePacData data

      deferred.resolve
        cumulative: cumulativeData
        individual: data

    deferred.promise

  exportToExcel: (params) ->
    exportUrl = urlFor(params, 'xlsx')
    $window.location.assign exportUrl
