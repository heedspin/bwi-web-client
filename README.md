# bwi-web-client

An AngularJS client-side application that consumes the BWI API.

## Development

### Setup

1. Install [Node/NPM](http://nodejs.org).

1. Install global build tools.

        $ npm install --global bower
        $ npm install --global gulp

1. Install packages.

        $ bower install
        $ npm install

1. Start the development server.

        $ gulp serve

    The app is configured to consume the staging API, so it will accept any
    staging credentials for authorization. This can be changed in
    `app/javascripts/app.coffee`.

## Deployment

### Staging

Add your public SSH key to the *deployer* user and then run:

    $ bin/deploy staging
