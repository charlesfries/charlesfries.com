import Controller from '@ember/controller';
import { tracked } from '@glimmer/tracking';
import type { Type } from 'charlesfries/routes/repositories/index';

export default class RepositoriesIndexController extends Controller {
  queryParams = ['type'];

  @tracked type?: Type;
}
