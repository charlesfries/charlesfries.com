import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { query } from '@warp-drive/utilities/json-api';
import type { Document } from 'charlesfries/handlers/github';
import type Store from 'charlesfries/services/store';

export type Sort = 'created' | 'updated' | 'pushed' | 'name';
export type Direction = 'asc' | 'desc';
export type Type = 'sources' | 'forks';

type Params = {
  sort: Sort;
  direction: Direction;
  after?: string;
  before?: string;
};

const removeNullish = <T>(obj: { [key: string]: T }) =>
  Object.fromEntries(Object.entries(obj).filter(([, value]) => value != null));

export default class IndexRoute extends Route {
  @service declare store: Store;

  queryParams = {
    sort: { refreshModel: true },
    direction: { refreshModel: true },
    after: { refreshModel: true },
    before: { refreshModel: true },
  };

  model(params: Params) {
    const cleanParams = removeNullish(params);

    const requestOptions = query('repository', cleanParams, {
      backgroundReload: true,
    });

    return {
      request: this.store.request<Document>(requestOptions),
    };
  }
}
