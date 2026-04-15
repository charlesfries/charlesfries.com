import Controller from '@ember/controller';
import { tracked } from '@glimmer/tracking';
import type { Direction, Sort } from 'charlesfries/routes/repositories/index';

export default class RepositoriesController extends Controller {
  @tracked sort: Sort = 'pushed';
  @tracked direction: Direction = 'desc';
  @tracked after?: string;
  @tracked before?: string;
}
