import Route from '@ember/routing/route';
import { service } from '@ember/service';
import type { Article } from 'charlesfries/schemas/article';
import type Store from 'charlesfries/services/store';

export default class ArticlesRoute extends Route {
  @service declare store: Store;

  model() {
    return this.store.request<Article[]>({
      url: `https://dev.to/api/articles?username=charlesfries`,
    });
  }
}
