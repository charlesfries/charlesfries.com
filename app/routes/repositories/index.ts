import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { query } from '@warp-drive/utilities/json-api';
import type { Doc } from 'charlesfries/handlers/github';
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

export default class RepositoriesIndexRoute extends Route {
  @service declare store: Store;

  model() {
    const params = this.paramsFor('repositories') as Params;

    const clean = Object.fromEntries(
      Object.entries(params).filter(([, value]) => value != null),
    );

    const options = query('repository', clean, {
      backgroundReload: true,
    });

    return {
      request: this.store.request<Doc>(options),
      params,
    };
  }
}
