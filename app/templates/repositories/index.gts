import type Route from '@ember/routing/route';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import { faArrowUpRightFromSquare } from '@fortawesome/free-solid-svg-icons';
import Component from '@glimmer/component';
import { Request } from '@warp-drive/ember';
import Error from 'charlesfries/components/error';
import Grid from 'charlesfries/components/grid';
import Pagination from 'charlesfries/components/pagination';
import Placeholder from 'charlesfries/components/placeholder';
import RateLimit from 'charlesfries/components/rate-limit';
import RepositoryCard from 'charlesfries/components/repository';
import type RepositoriesIndexController from 'charlesfries/controllers/repositories/index';
import type { Doc } from 'charlesfries/handlers/github';
import type RepositoriesIndexRoute from 'charlesfries/routes/repositories/index';
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

interface RepositoriesIndexSignature {
  Args: {
    model: ModelFrom<RepositoriesIndexRoute>;
    controller: RepositoriesIndexController;
  };
}

export default class RepositoriesIndex extends Component<RepositoriesIndexSignature> {
  repositories = (repositories: Doc['data']) => {
    const { controller } = this.args;
    return repositories.filter(({ isFork }) => {
      if (controller.type) {
        return isFork === ('forks' === controller.type);
      }
      return true;
    });
  };

  <template>
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
