import type { Handler, NextFn } from '@warp-drive/core/request';
import type { RequestContext } from '@warp-drive/core/types/request';

export interface TextBody {
  text: string;
}

export const Text: Handler = {
  async request<T>(context: RequestContext, next: NextFn<T>) {
    const { request } = context;

    if (!request.headers?.get('Accept')?.includes('text/plain')) {
      return next(request);
    }

    // eslint-disable-next-line warp-drive/no-external-request-patterns
    const response = await fetch(request.url!);
    const data = await response.text();

    return { text: data } as T;
  },
};
