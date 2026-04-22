import type { Handler, NextFn } from '@warp-drive/core/request';
import type { RequestContext } from '@warp-drive/core/types/request';

interface DevCommunityArticle {
  id: number;
  [key: string]: unknown;
}

export const DevCommunity: Handler = {
  async request<T>(context: RequestContext, next: NextFn<T>) {
    const { request } = context;

    if (!request.url?.includes('dev.to')) {
      return next(request);
    }

    const result = await next(request);

    result.content = {
      data: (result.content as DevCommunityArticle[]).map(
        ({ id, ...attributes }) => ({
          type: 'article',
          id: id.toString(),
          attributes,
        }),
      ),
    } as T;

    return result;
  },
};
