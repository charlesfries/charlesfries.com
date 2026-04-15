import type RouterService from '@ember/routing/router-service';
import { service } from '@ember/service';
import Component from '@glimmer/component';
import Description from 'charlesfries/components/description';
import Socials from 'charlesfries/components/socials';
import Technologies from 'charlesfries/components/technologies';
import Toolbar from 'charlesfries/components/toolbar';

export default class Repositories extends Component {
  @service declare router: RouterService;

  refresh = () => {
    this.router.refresh();
  };

  <template>
    <section class="flex flex-col items-center gap-8 mb-12">
      <div class="flex flex-col items-center gap-8 max-w-lg text-center">
        <Description />
        <Socials />
      </div>
      <div class="max-w-3xl">
        <Technologies />
      </div>
    </section>
    <Toolbar @onRefresh={{this.refresh}} />
    {{outlet}}
  </template>
}
