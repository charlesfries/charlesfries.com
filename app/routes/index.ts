import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { query } from '@warp-drive/utilities/json-api';
import type { Repository } from 'charlesfries/schemas/repository';
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

export type Meta = {
  hasNextPage: boolean;
  hasPreviousPage: boolean;
  startCursor: string | null;
  endCursor: string | null;
};

export default class IndexRoute extends Route {
  @service declare store: Store;

  async model() {
    const params = this.paramsFor('application') as Params;

    const clean = Object.fromEntries(
      Object.entries(params).filter(([, value]) => value != null),
    );

    const options = query<Repository>('repository', clean, {
      backgroundReload: true,
    });
    const { response, content } = await this.store.request(options);

    const remainingRequests = response?.headers.get('X-RateLimit-Remaining');
    const maxRequests = response?.headers.get('X-RateLimit-Limit');
    const resetAt = response?.headers.get('X-RateLimit-Reset');

    return {
      repositories: content.data,
      meta: content.meta,
      remainingRequests: remainingRequests ? Number(remainingRequests) : null,
      maxRequests: maxRequests ? Number(maxRequests) : null,
      resetAt: resetAt ? new Date(Number(resetAt) * 1000) : null,
    };
  }
}
