import { LinkTo } from '@ember/routing';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import { faArrowLeft, faArrowRight } from '@fortawesome/free-solid-svg-icons';
import Component from '@glimmer/component';
import type { Meta } from 'charlesfries/routes/repositories/index';
import { BUTTON } from 'charlesfries/utils/class-names';
import { t } from 'ember-intl';

const DISABLED_CLASS = 'opacity-50 pointer-events-none';

export interface PaginationSignature {
  Args: {
    meta: Meta;
    isBackward: boolean | null;
  };
}

export default class Pagination extends Component<PaginationSignature> {
  // aliases

  get isBackward() {
    return this.args.isBackward;
  }

  get meta() {
    return this.args.meta;
  }

  // navigation conditions

  get canPrevious() {
    return this.isBackward === false || (this.isBackward && this.meta.hasMore);
  }

  get canNext() {
    return this.isBackward || this.meta.hasMore;
  }

  // queries

  get previousQuery() {
    return { before: this.meta.first, after: undefined };
  }

  get nextQuery() {
    return { after: this.meta.last, before: undefined };
  }

  <template>
    <div class="flex justify-center pt-10">
      <LinkTo
        @query={{this.previousQuery}}
        class="{{BUTTON.secondary}}
          rounded-l-lg -mr-px
          {{unless this.canPrevious DISABLED_CLASS}}"
        aria-label={{t "pagination.previous"}}
        aria-disabled={{unless this.canPrevious true}}
      >
        <FaIcon @icon={{faArrowLeft}} class="mr-1" />
        {{t "pagination.previous"}}
      </LinkTo>

      <LinkTo
        @query={{this.nextQuery}}
        class="{{BUTTON.secondary}}
          rounded-r-lg
          {{unless this.canNext DISABLED_CLASS}}"
        aria-label={{t "pagination.next"}}
        aria-disabled={{unless this.canNext true}}
      >
        {{t "pagination.next"}}
        <FaIcon @icon={{faArrowRight}} class="ml-1" />
      </LinkTo>
    </div>
  </template>
}
