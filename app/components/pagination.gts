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
  <div class="flex justify-center pt-10">
    <LinkTo
      @query={{if
        (or (eq false @isBackward) (and @isBackward @meta.hasMore))
        (hash before=@meta.first after=undefined)
        (hash)
      }}
      class="{{BUTTON.secondary}}
        rounded-l-lg -mr-px
        {{unless
          (or (eq false @isBackward) (and @isBackward @meta.hasMore))
          'opacity-50 pointer-events-none'
        }}"
      aria-label={{t "pagination.previous"}}
      aria-disabled={{unless
        (or (eq false @isBackward) (and @isBackward @meta.hasMore))
        "true"
      }}
    >
      <FaIcon @icon={{faArrowLeft}} class="mr-1" />
      {{t "pagination.previous"}}
    </LinkTo>
    <LinkTo
      @query={{if
        (or @isBackward @meta.hasMore)
        (hash after=@meta.last before=undefined)
        (hash)
      }}
      class="{{BUTTON.secondary}}
        rounded-r-lg
        {{unless
          (or @isBackward @meta.hasMore)
          'opacity-50 pointer-events-none'
        }}"
      aria-label={{t "pagination.next"}}
      aria-disabled={{unless (or @isBackward @meta.hasMore) "true"}}
    >
      {{t "pagination.next"}}
      <FaIcon @icon={{faArrowRight}} class="ml-1" />
    </LinkTo>
  </div>
</template> satisfies TOC<PaginationSignature>;
