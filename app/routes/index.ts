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

type PageInfo = {
  hasNextPage: boolean;
  hasPreviousPage: boolean;
  startCursor: string | null;
  endCursor: string | null;
};

export default class IndexRoute extends Route {
  @service declare store: Store;

  async model() {
    const params = this.paramsFor('application') as Params;

    const cp = { ...params };

    console.log(cp);

    if (!cp.before) {
      delete cp.before;
    }
    if (!cp.after) {
      delete cp.after;
    }

    console.log(cp);

    const options = query<Repository>('repository', cp, {
      backgroundReload: true,
    });
    const { response, content } = await this.store.request(options);

    const remainingRequests = response?.headers.get('X-RateLimit-Remaining');
    const maxRequests = response?.headers.get('X-RateLimit-Limit');
    const resetAt = response?.headers.get('X-RateLimit-Reset');

    return {
      repositories: content.data,
      remainingRequests: remainingRequests ? Number(remainingRequests) : null,
      maxRequests: maxRequests ? Number(maxRequests) : null,
      resetAt: resetAt ? new Date(Number(resetAt) * 1000) : null,
      pageInfo: (content.meta?.pageInfo as PageInfo | undefined) ?? {
        hasNextPage: false,
        hasPreviousPage: false,
        startCursor: null,
        endCursor: null,
      },
    };
  }
}
