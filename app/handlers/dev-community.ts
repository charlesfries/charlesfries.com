import type { Handler, NextFn } from '@warp-drive/core/request';
import type {
  RequestContext,
  StructuredDataDocument,
} from '@warp-drive/core/types/request';

export const DevCommunity: Handler = {
  async request<T>(context: RequestContext, next: NextFn<T>) {
    const { request } = context;

    if (!request.url?.includes('dev.to')) {
      return next(request);
    }

    const result = (await next(request)) as StructuredDataDocument<Document>;

    result.content = {
      data: result.content.map(({ id, ...attributes }) => ({
        type: 'article',
        id: id.toString(),
        attributes,
      })),
    };

    return result as T;
  },
};
