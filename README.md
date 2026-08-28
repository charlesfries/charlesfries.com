[![GitHub Actions Status](https://github.com/charlesfries/charlesfries.com/actions/workflows/ci.yml/badge.svg)](https://github.com/charlesfries/charlesfries.com/actions/workflows/ci.yml) [![Netlify Status](https://api.netlify.com/api/v1/badges/6dc94a82-a84c-4803-8570-22f2550deb2f/deploy-status)](https://app.netlify.com/projects/charlesfries/deploys)

# charlesfries

This is the source for the portfolio website [charlesfries.com](https://charlesfries.com). The client is an Ember application, and the server is comprised of Netlify Functions. The client and server are both hosted by the same origin.

## Prerequisites

You will need the following things properly installed on your computer.

- [Git](https://git-scm.com/)
- [Node.js](https://nodejs.org/) (with npm)
- [Google Chrome](https://google.com/chrome/)

## Installation

- `git clone <repository-url>` this repository
- `cd charlesfries`
- `npm install`

## Configure Netlify Locally

Netlify must be linked on the local server to pull in environment variables.

- `npm install --global netlify-cli`
- `netlify link`

## Running / Development

- `npm run dev`
- Visit your app at [http://localhost:8888](http://localhost:8888).
- Visit your tests at [http://localhost:8888/tests](http://localhost:8888/tests).

### Code Generators

Make use of the many generators for code, try `npm exec ember help generate` for more details

### Running Tests

- `npm run test`

### Linting

- `npm run lint`
- `npm run lint:fix`

### Building

- `npm exec vite build --mode development` (development)
- `npm run build` (production)

### Deploying

Specify what it takes to deploy your app.

## Further Reading / Useful Links

- [ember.js](https://emberjs.com/)
- [Vite](https://vite.dev)
- Development Browser Extensions
  - [ember inspector for chrome](https://chrome.google.com/webstore/detail/ember-inspector/bmdblncegkenkacieihfhpjfppoconhi)
  - [ember inspector for firefox](https://addons.mozilla.org/en-US/firefox/addon/ember-inspector/)
