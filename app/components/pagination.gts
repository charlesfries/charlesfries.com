import type { TOC } from '@ember/component/template-only';
import { hash } from '@ember/helper';
import { LinkTo } from '@ember/routing';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import { faArrowLeft, faArrowRight } from '@fortawesome/free-solid-svg-icons';
import type { Meta } from 'charlesfries/routes/repositories/index';
import { BUTTON } from 'charlesfries/utils/class-names';
import { t } from 'ember-intl';

const eq = (a: unknown, b: unknown) => a === b;

const and = (...args: unknown[]) => args.every(Boolean);

const or = (a: unknown, b: unknown) => Boolean(a || b);

export interface PaginationSignature {
  Args: {
    meta: Meta;
    isBackward: boolean | null;
  };
}

<template>
  <div class="flex justify-center gap-3 pt-10">
    {{#if (or (eq false @isBackward) (and @isBackward @meta.hasMore))}}
      <LinkTo
        @query={{hash before=@meta.first after=undefined}}
        class="{{BUTTON.secondary}} rounded-lg"
        aria-label={{t "pagination.previous"}}
      >
        <FaIcon @icon={{faArrowLeft}} class="mr-1" />
        {{t "pagination.previous"}}
      </LinkTo>
    {{/if}}
    {{#if (or @isBackward @meta.hasMore)}}
      <LinkTo
        @query={{hash after=@meta.last before=undefined}}
        class="{{BUTTON.secondary}} rounded-lg"
        aria-label={{t "pagination.next"}}
      >
        {{t "pagination.next"}}
        <FaIcon @icon={{faArrowRight}} class="ml-1" />
      </LinkTo>
    {{/if}}
  </div>
</template> satisfies TOC<PaginationSignature>;
