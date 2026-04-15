import type RouterService from '@ember/routing/router-service';
import { service } from '@ember/service';
import Component from '@glimmer/component';
import Toolbar from 'charlesfries/components/toolbar';

export default class Repositories extends Component {
  @service declare router: RouterService;

  refresh = () => {
    this.router.refresh();
  };

  <template>
    <Toolbar @onRefresh={{this.refresh}} />
    {{outlet}}
  </template>
}
