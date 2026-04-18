import Route from '@ember/routing/route';
import { service } from '@ember/service';
import type { ObjectValue } from '@warp-drive/core/types/json/raw';
import type { QueryRequestOptions } from '@warp-drive/core/types/request';
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

export interface Meta extends ObjectValue {
  hasMore: boolean;
  first: string | null;
  last: string | null;
  remainingRequests: number | null;
  maxRequests: number | null;
  resetAt: Date | null;
}

export default class RepositoriesIndexRoute extends Route {
  @service declare store: Store;

  model() {
    const params = this.paramsFor('repositories') as Params;

    const clean = Object.fromEntries(
      Object.entries(params).filter(([, value]) => value != null),
    );

    const options = query('repository', clean, {
      backgroundReload: true,
    }) as QueryRequestOptions<Doc>;

    return {
      request: this.store.request(options),
      params,
    };
  }
}
