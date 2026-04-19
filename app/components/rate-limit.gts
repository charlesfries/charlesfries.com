import type { TOC } from '@ember/component/template-only';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import { faInfoCircle } from '@fortawesome/free-solid-svg-icons';
import { formatNumber, formatTime, t } from 'ember-intl';

const eq = (a: unknown, b: unknown) => a === b;

const isRunningLow = (remaining: number | null, max: number | null) => {
  if (remaining === null || max === null) {
    return false;
  }
  return remaining <= max * 0.1;
};

const toDate = (dateStr: string | null) => new Date(Number(dateStr) * 1000);

export interface RateLimitSignature {
  Args: {
    remaining: number | null;
    max: number | null;
    resetAt: string | null;
  };
}

<template>
  <div
    class="text-sm text-right mb-6
      {{if
        (isRunningLow @remaining @max)
        'text-red-500'
        'text-neutral-500 dark:text-neutral-400'
      }}"
  >
    <FaIcon @icon={{faInfoCircle}} class="mr-1" />
    {{#unless (eq null @remaining)}}
      {{t
        "requests"
        remaining=(formatNumber @remaining)
        max=(formatNumber @max)
        resetAt=(formatTime (toDate @resetAt))
      }}
    {{/unless}}
  </div>
</template> satisfies TOC<RateLimitSignature>;
