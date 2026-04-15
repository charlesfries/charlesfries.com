import type Route from '@ember/routing/route';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import { faArrowUpRightFromSquare } from '@fortawesome/free-solid-svg-icons';
import Component from '@glimmer/component';
import Grid from 'charlesfries/components/grid';
import Pagination from 'charlesfries/components/pagination';
import RateLimit from 'charlesfries/components/rate-limit';
import RepositoryCard from 'charlesfries/components/repository';
import type RepositoriesIndexController from 'charlesfries/controllers/repositories/index';
import type RepositoriesIndexRoute from 'charlesfries/routes/repositories/index';
import { BUTTON } from 'charlesfries/utils/class-names';
import { t } from 'ember-intl';

type ModelFrom<R extends Route> = Awaited<ReturnType<R['model']>>;

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

export default class Index extends Component<RepositoriesIndexSignature> {
  get repositories() {
    const { model, controller } = this.args;
    return model.repositories.filter(({ isFork }) => {
      if (controller.type) {
        return isFork === ('forks' === controller.type);
      }
      return true;
    });
  }

  <template>
    <RateLimit
      @remaining={{@model.remainingRequests}}
      @max={{@model.maxRequests}}
      @resetAt={{@model.resetAt}}
    />
    <Grid>
      {{#each this.repositories as |repository|}}
        <RepositoryCard @repository={{repository}} />
      {{/each}}
    </Grid>
    <div class="flex justify-center gap-3 pt-10">
      <Pagination
        @meta={{@model.meta}}
        @isBackward={{if @model.before true (if @model.after false null)}}
      />
    </div>
    <MoreButton />
  </template>
}
