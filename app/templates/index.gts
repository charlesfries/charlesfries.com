import type Route from '@ember/routing/route';
import type RouterService from '@ember/routing/router-service';
import { service } from '@ember/service';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import { faArrowUpRightFromSquare } from '@fortawesome/free-solid-svg-icons';
import Component from '@glimmer/component';
import { Request } from '@warp-drive/ember';
import Description from 'charlesfries/components/description';
import Error from 'charlesfries/components/error';
import Grid from 'charlesfries/components/grid';
import Pagination from 'charlesfries/components/pagination';
import Placeholder from 'charlesfries/components/placeholder';
import RateLimit from 'charlesfries/components/rate-limit';
import RepositoryCard from 'charlesfries/components/repository';
import Socials from 'charlesfries/components/socials';
import Technologies from 'charlesfries/components/technologies';
import Toolbar from 'charlesfries/components/toolbar';
import type IndexController from 'charlesfries/controllers/index';
import type { Document } from 'charlesfries/handlers/github';
import type IndexRoute from 'charlesfries/routes/index';
import { BUTTON } from 'charlesfries/utils/class-names';
import { t } from 'ember-intl';

type ModelFrom<R extends Route> = Awaited<ReturnType<R['model']>>;

const range = (length: number) => new Array<void>(length);

const MoreButton = <template>
  <a
    class="{{BUTTON.primary}} block w-fit mx-auto mt-10"
    href="https://github.com/charlesfries"
    role="button"
  >
    <FaIcon
      @icon={{faArrowUpRightFromSquare}}
      class="mr-1"
      role="presentation"
    />
    {{t "more"}}
  </a>
</template>;

interface IndexSignature {
  Args: {
    model: ModelFrom<IndexRoute>;
    controller: IndexController;
  };
}

export default class Index extends Component<IndexSignature> {
  @service declare router: RouterService;

  repositories = (repositories: Document['data']) => {
    const { controller } = this.args;
    return repositories.filter(({ isFork }) => {
      if (controller.type) {
        return isFork === ('forks' === controller.type);
      }
      return true;
    });
  };

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

    <Request @request={{@model.request}}>
      <:loading>
        <style>
          .vertical-fade {
            mask-image: linear-gradient(to bottom, black 0%, transparent 100%);
          }
        </style>

        <RateLimit @remaining={{null}} @max={{null}} @resetAt={{null}} />
        <Grid class="vertical-fade">
          {{#each (range 32)}}
            <Placeholder />
          {{/each}}
        </Grid>
      </:loading>

      <:error as |error|>
        <Error @error={{error}} @message={{t "error"}} />
      </:error>

      <:content as |content|>
        <RateLimit
          @remaining={{content.meta.remainingRequests}}
          @max={{content.meta.maxRequests}}
          @resetAt={{content.meta.resetAt}}
        />
        <Grid>
          {{#each (this.repositories content.data) as |repository|}}
            <RepositoryCard @repository={{repository}} />
          {{/each}}
        </Grid>
        <Pagination
          @meta={{content.meta}}
          @isBackward={{if
            @model.params.before
            true
            (if @model.params.after false null)
          }}
        />
        <MoreButton />
      </:content>
    </Request>
  </template>
}
