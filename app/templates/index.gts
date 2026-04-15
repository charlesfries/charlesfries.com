import type { TOC } from '@ember/component/template-only';
import { hash } from '@ember/helper';
import { LinkTo } from '@ember/routing';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import {
  faArrowLeft,
  faArrowRight,
  faArrowUpRightFromSquare,
} from '@fortawesome/free-solid-svg-icons';
import Component from '@glimmer/component';
import Grid from 'charlesfries/components/grid';
import RateLimit from 'charlesfries/components/rate-limit';
import RepositoryCard from 'charlesfries/components/repository';
import { BUTTON_CLASS_NAME } from 'charlesfries/components/toolbar';
import type IndexController from 'charlesfries/controllers/index';
import type { PageInfo } from 'charlesfries/routes/index';
import type { Repository } from 'charlesfries/schemas/repository';
import { t } from 'ember-intl';

const Pagination: TOC<{
  pageInfo: PageInfo;
}> = <template>
  {{#if @pageInfo.hasPreviousPage}}
    <LinkTo
      @query={{hash before=@pageInfo.startCursor after=undefined}}
      class="{{BUTTON_CLASS_NAME}} rounded-lg"
      aria-label={{t "pagination.previous"}}
    >
      <FaIcon @icon={{faArrowLeft}} class="mr-1" />
      {{t "pagination.previous"}}
    </LinkTo>
  {{/if}}
  {{#if @pageInfo.hasNextPage}}
    <LinkTo
      @query={{hash after=@pageInfo.endCursor before=undefined}}
      class="{{BUTTON_CLASS_NAME}} rounded-lg"
      aria-label={{t "pagination.next"}}
    >
      {{t "pagination.next"}}
      <FaIcon @icon={{faArrowRight}} class="ml-1" />
    </LinkTo>
  {{/if}}
</template>;

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
      pageInfo: PageInfo;
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
      <Pagination @pageInfo={{@model.pageInfo}} />
    </div>
    <div class="flex justify-center pt-10">
      <MoreButton />
    </div>
  </template>
}
