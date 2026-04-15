import EmberRouter from '@embroider/router';
import config from 'charlesfries/config/environment';

export default class Router extends EmberRouter {
  location = config.locationType;
  rootURL = config.rootURL;
}

Router.map(function () {
  this.route('repositories', { path: '/' }, function () {});
});
