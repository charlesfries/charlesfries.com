import { LinkTo } from '@ember/routing';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import { faArrowLeft, faArrowRight } from '@fortawesome/free-solid-svg-icons';
import Component from '@glimmer/component';
import type { Meta } from 'charlesfries/routes/repositories/index';
import { BUTTON } from 'charlesfries/utils/class-names';
import { t } from 'ember-intl';

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

  get canGoPrev() {
    return this.isBackward === false || (this.isBackward && this.meta.hasMore);
  }

  get canGoNext() {
    return this.isBackward || this.meta.hasMore;
  }

  // queries

  get prevQuery() {
    return this.canGoPrev ? { before: this.meta.first, after: undefined } : {};
  }

  get nextQuery() {
    return this.canGoNext ? { after: this.meta.last, before: undefined } : {};
  }

  // classes

  get prevClasses() {
    return [
      BUTTON.secondary,
      'rounded-l-lg -mr-px',
      !this.canGoPrev && 'opacity-50 pointer-events-none',
    ]
      .filter(Boolean)
      .join(' ');
  }

  get nextClasses() {
    return [
      BUTTON.secondary,
      'rounded-r-lg',
      !this.canGoNext && 'opacity-50 pointer-events-none',
    ]
      .filter(Boolean)
      .join(' ');
  }

  // a11y

  get prevAriaDisabled() {
    return this.canGoPrev ? undefined : 'true';
  }

  get nextAriaDisabled() {
    return this.canGoNext ? undefined : 'true';
  }

  <template>
    <div class="flex justify-center pt-10">
      <LinkTo
        @query={{this.prevQuery}}
        class={{this.prevClasses}}
        aria-label={{t "pagination.previous"}}
        aria-disabled={{this.prevAriaDisabled}}
      >
        <FaIcon @icon={{faArrowLeft}} class="mr-1" />
        {{t "pagination.previous"}}
      </LinkTo>

      <LinkTo
        @query={{this.nextQuery}}
        class={{this.nextClasses}}
        aria-label={{t "pagination.next"}}
        aria-disabled={{this.nextAriaDisabled}}
      >
        {{t "pagination.next"}}
        <FaIcon @icon={{faArrowRight}} class="ml-1" />
      </LinkTo>
    </div>
  </template>
}
