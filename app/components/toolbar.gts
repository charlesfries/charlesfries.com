import type { TOC } from '@ember/component/template-only';
import { hash } from '@ember/helper';
import { on } from '@ember/modifier';
import { LinkTo } from '@ember/routing';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import {
  faRedo,
  faSortAmountDown,
  faSortAmountUp,
} from '@fortawesome/free-solid-svg-icons';
import { BUTTON, DISABLED_CLASS } from 'charlesfries/utils/class-names';
import { t } from 'ember-intl';

export interface ToolbarSignature {
  isLoading: boolean;
  onRefresh: () => void;
}

<template>
  <div id="toolbar" class="flex flex-wrap gap-2 mb-6">
    <button
      type="button"
      class="{{BUTTON.secondary}}
        {{if @isLoading DISABLED_CLASS}}
        rounded-lg cursor-pointer"
      aria-label={{t "refresh"}}
      disabled={{@isLoading}}
      {{on "click" @onRefresh}}
    >
      <FaIcon @icon={{faRedo}} />
    </button>
    <div class="flex">
      <LinkTo
        @query={{hash sort="created" after=undefined before=undefined}}
        class="{{BUTTON.secondary}} rounded-l-lg -mr-px"
      >
        {{t "sort.created"}}
      </LinkTo>
      <LinkTo
        @query={{hash sort="updated" after=undefined before=undefined}}
        class="{{BUTTON.secondary}} -mr-px"
      >
        {{t "sort.updated"}}
      </LinkTo>
      <LinkTo
        @query={{hash sort="pushed" after=undefined before=undefined}}
        class="{{BUTTON.secondary}} -mr-px"
      >
        {{t "sort.pushed"}}
      </LinkTo>
      <LinkTo
        @query={{hash sort="name" after=undefined before=undefined}}
        class="{{BUTTON.secondary}} rounded-r-lg"
      >
        {{t "sort.name"}}
      </LinkTo>
    </div>
    <div class="flex">
      <LinkTo
        @query={{hash direction="desc" after=undefined before=undefined}}
        class="{{BUTTON.secondary}} rounded-l-lg -mr-px"
        role="button"
        aria-label={{t "sortDescending"}}
      >
        <FaIcon @icon={{faSortAmountDown}} role="presentation" />
      </LinkTo>
      <LinkTo
        @query={{hash direction="asc" after=undefined before=undefined}}
        class="{{BUTTON.secondary}} rounded-r-lg"
        role="button"
        aria-label={{t "sortAscending"}}
      >
        <FaIcon @icon={{faSortAmountUp}} role="presentation" />
      </LinkTo>
    </div>
    <div class="flex">
      <LinkTo
        @query={{hash type=undefined after=undefined before=undefined}}
        class="{{BUTTON.secondary}} rounded-l-lg -mr-px"
        role="button"
      >
        {{t "type.all"}}
      </LinkTo>
      <LinkTo
        @query={{hash type="sources" after=undefined before=undefined}}
        class="{{BUTTON.secondary}} -mr-px"
        role="button"
      >
        {{t "type.sources"}}
      </LinkTo>
      <LinkTo
        @query={{hash type="forks" after=undefined before=undefined}}
        class="{{BUTTON.secondary}} rounded-r-lg"
        role="button"
      >
        {{t "type.forks"}}
      </LinkTo>
    </div>
  </div>
</template> satisfies TOC<ToolbarSignature>;
