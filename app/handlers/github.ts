import type { ReactiveDataDocument } from '@warp-drive/core/reactive';
import type { Handler, NextFn } from '@warp-drive/core/request';
import type {
  RequestContext,
  StructuredDataDocument,
} from '@warp-drive/core/types/request';
import type { Meta } from 'charlesfries/routes/repositories/index';
import type { Repository } from 'charlesfries/schemas/repository';

export interface Doc extends ReactiveDataDocument<Repository[]> {
  meta: Meta;
}

export const GitHub: Handler = {
  async request<T>(context: RequestContext, next: NextFn<T>) {
    const { request } = context;

    const result = (await next(request)) as StructuredDataDocument<Doc>;

    const { response } = result;

    const remainingRequests = response?.headers.get('X-RateLimit-Remaining');
    const maxRequests = response?.headers.get('X-RateLimit-Limit');
    const resetAt = response?.headers.get('X-RateLimit-Reset');

    result.content.meta.remainingRequests = remainingRequests
      ? Number(remainingRequests)
      : null;
    result.content.meta.maxRequests = maxRequests ? Number(maxRequests) : null;
    result.content.meta.resetAt = resetAt
      ? new Date(Number(resetAt) * 1000)
      : null;

    return result as T;
  },
};
