import { hash } from '@ember/helper';
import { LinkTo } from '@ember/routing';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import { faArrowUpRightFromSquare } from '@fortawesome/free-solid-svg-icons';
import Component from '@glimmer/component';
import Grid from 'charlesfries/components/grid';
import RateLimit from 'charlesfries/components/rate-limit';
import RepositoryCard from 'charlesfries/components/repository';
import type IndexController from 'charlesfries/controllers/index';
import type { Repository } from 'charlesfries/schemas/repository';
import { t } from 'ember-intl';

const MoreButton = <template>
  <a
    class="bg-blue-700 hover:bg-blue-900 text-white font-semibold px-3 py-2 rounded-lg"
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
    model: {
      repositories: Repository[];
      remainingRequests: number | null;
      maxRequests: number | null;
      resetAt: Date | null;
      pageInfo: {
        hasNextPage: boolean;
        hasPreviousPage: boolean;
        startCursor: string | null;
        endCursor: string | null;
      };
    };
    controller: IndexController;
  };
}

export default class Index extends Component<IndexSignature> {
  get repositories() {
    const { repositories } = this.args.model;
    return repositories.filter(({ isFork }) => {
      if (this.args.controller.type) {
        return isFork === ('forks' === this.args.controller.type);
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
        <div>
          <RepositoryCard @repository={{repository}} />
        </div>
      {{/each}}
    </Grid>
    <div class="flex justify-center gap-3 pt-10">
      {{#if @model.pageInfo.hasPreviousPage}}
        <LinkTo
          @query={{hash before=@model.pageInfo.startCursor after=undefined}}
          class="bg-white dark:bg-neutral-800 border border-neutral-300 dark:border-neutral-600 hover:bg-neutral-100 dark:hover:bg-neutral-700 font-semibold px-4 py-2 rounded-lg"
          aria-label={{t "pagination.previous"}}
        >
          {{t "pagination.previous"}}
        </LinkTo>
      {{/if}}
      {{#if @model.pageInfo.hasNextPage}}
        <LinkTo
          @query={{hash after=@model.pageInfo.endCursor before=undefined}}
          class="bg-white dark:bg-neutral-800 border border-neutral-300 dark:border-neutral-600 hover:bg-neutral-100 dark:hover:bg-neutral-700 font-semibold px-4 py-2 rounded-lg"
          aria-label={{t "pagination.next"}}
        >
          {{t "pagination.next"}}
        </LinkTo>
      {{/if}}
    </div>
    <div class="flex justify-center pt-10">
      <MoreButton />
    </div>
  </template>
}
