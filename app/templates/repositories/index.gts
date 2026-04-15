import type { TOC } from '@ember/component/template-only';
import { hash } from '@ember/helper';
import { LinkTo } from '@ember/routing';
import type Route from '@ember/routing/route';
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
import type RepositoriesIndexController from 'charlesfries/controllers/repositories/index';
import type RepositoriesIndexRoute from 'charlesfries/routes/repositories/index';
import type { Meta } from 'charlesfries/routes/repositories/index';
import { BUTTON } from 'charlesfries/utils/class-names';
import { t } from 'ember-intl';

type ModelFrom<R extends Route> = Awaited<ReturnType<R['model']>>;

const eq = (a: unknown, b: unknown) => a === b;

const Pagination: TOC<{
  meta: Meta;
  isBackward: boolean | null;
}> = <template>
  {{#if (if (eq false @isBackward) true (if @isBackward @meta.hasMore false))}}
    <LinkTo
      @query={{hash before=@meta.first after=undefined}}
      class="{{BUTTON.secondary}} rounded-lg"
      aria-label={{t "pagination.previous"}}
    >
      <FaIcon @icon={{faArrowLeft}} class="mr-1" />
      {{t "pagination.previous"}}
    </LinkTo>
  {{/if}}
  {{#if (if @isBackward true @meta.hasMore)}}
    <LinkTo
      @query={{hash after=@meta.last before=undefined}}
      class="{{BUTTON.secondary}} rounded-lg"
      aria-label={{t "pagination.next"}}
    >
      {{t "pagination.next"}}
      <FaIcon @icon={{faArrowRight}} class="ml-1" />
    </LinkTo>
  {{/if}}
</template>;

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
      <Pagination
        @meta={{@model.meta}}
        @isBackward={{if @model.before true (if @model.after false null)}}
      />
    </div>
    <MoreButton />
  </template>
}
