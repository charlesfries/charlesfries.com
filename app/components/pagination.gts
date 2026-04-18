import { hash } from '@ember/helper';
import { LinkTo } from '@ember/routing';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import { faArrowLeft, faArrowRight } from '@fortawesome/free-solid-svg-icons';
import Component from '@glimmer/component';
import type { Meta } from 'charlesfries/handlers/github';
import { BUTTON } from 'charlesfries/utils/class-names';
import { t } from 'ember-intl';

const DISABLED_CLASS = 'opacity-55 pointer-events-none';

export interface PaginationSignature {
  Args: {
    meta: Meta;
    isBackward: boolean | null;
  };
}

export default class Pagination extends Component<PaginationSignature> {
  get canPrevious() {
    return (
      this.args.isBackward === false ||
      (this.args.isBackward && this.args.meta.hasMore)
    );
  }

  get canNext() {
    return this.args.isBackward || this.args.meta.hasMore;
  }

  <template>
    <div class="flex justify-center pt-10">
      <LinkTo
        @query={{hash before=@meta.first after=undefined}}
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
        @query={{hash after=@meta.last before=undefined}}
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
