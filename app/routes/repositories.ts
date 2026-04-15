import Route from '@ember/routing/route';

export default class RepositoriesRoute extends Route {
  queryParams = {
    sort: { refreshModel: true },
    direction: { refreshModel: true },
    after: { refreshModel: true },
    before: { refreshModel: true },
  };
}
