module.exports =
  assets: [
    'coffee'
    'jade'
    'styl'
  ]

  build:
    alternates: [
      ['client/app.coffee', 'client/app-build.coffee']
    ]
