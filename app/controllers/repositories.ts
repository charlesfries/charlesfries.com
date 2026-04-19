import Controller from '@ember/controller';
import { tracked } from '@glimmer/tracking';
import type { Direction, Sort, Type } from 'charlesfries/routes/repositories';

export default class RepositoriesController extends Controller {
  queryParams = ['type'];

  @tracked sort: Sort = 'pushed';
  @tracked direction: Direction = 'desc';
  @tracked after?: string;
  @tracked before?: string;
  @tracked type?: Type;
}
