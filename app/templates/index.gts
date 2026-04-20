import type Route from '@ember/routing/route';
import type Router from '@ember/routing/router-service';
import { service } from '@ember/service';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import { faArrowUpRightFromSquare } from '@fortawesome/free-solid-svg-icons';
import Component from '@glimmer/component';
import { getRequestState, Request } from '@warp-drive/ember';
import Description from 'charlesfries/components/description';
import ErrorAlert from 'charlesfries/components/error-alert';
import Grid from 'charlesfries/components/grid';
import Pagination from 'charlesfries/components/pagination';
import RateLimitAlert from 'charlesfries/components/rate-limit-alert';
import RepositoryGridItem from 'charlesfries/components/repository-grid-item';
import RepositorySkeletonGridItem from 'charlesfries/components/repository-skeleton-grid-item';
import Socials from 'charlesfries/components/socials';
import Technologies from 'charlesfries/components/technologies';
import Toolbar from 'charlesfries/components/toolbar';
import type IndexController from 'charlesfries/controllers/index';
import type IndexRoute from 'charlesfries/routes/index';
import type { Repository } from 'charlesfries/schemas/repository';
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
  @service declare router: Router;

  get isLoading() {
    const state = getRequestState(this.args.model.request);
    return state.isLoading;
  }

  repositories = (repositories: Repository[]) => {
    const { type } = this.args.controller;
    return repositories.filter(({ isFork }) => {
      if (type) {
        return isFork === ('forks' === type);
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

    <Toolbar @isLoading={{this.isLoading}} @onRefresh={{this.refresh}} />

    <Request @request={{@model.request}}>
      <:loading>
        <style>
          .vertical-fade {
            mask-image: linear-gradient(to bottom, black 0%, transparent 100%);
          }
        </style>

        <RateLimitAlert @remaining={{null}} @max={{null}} @resetAt={{null}} />
        <Grid class="vertical-fade">
          {{#each (range 32)}}
            <RepositorySkeletonGridItem />
          {{/each}}
        </Grid>
      </:loading>

      <:error as |error|>
        <ErrorAlert @error={{error}} @message={{t "error"}} />
      </:error>

      <:content as |content|>
        <RateLimitAlert
          @remaining={{content.meta.remainingRequests}}
          @max={{content.meta.maxRequests}}
          @resetAt={{content.meta.resetAt}}
        />
        <Grid>
          {{#each (this.repositories content.data) as |repository|}}
            <RepositoryGridItem @repository={{repository}} />
          {{/each}}
        </Grid>
        <Pagination
          @meta={{content.meta}}
          @isBackward={{if
            @controller.before
            true
            (if @controller.after false null)
          }}
        />
        <MoreButton />
      </:content>
    </Request>
  </template>
}
