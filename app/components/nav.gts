import type { TOC } from '@ember/component/template-only';
import { LinkTo } from '@ember/routing';
import { t } from 'ember-intl';

const NavItem: TOC<{ route: string; label: string }> = <template>
  <li>
    <LinkTo
      @route={{@route}}
      class="inline-block py-4 px-6 text-neutral-500 dark:text-neutral-400 hover:text-neutral-800 dark:hover:text-neutral-100 font-medium border-b-2 border-transparent [&.active]:border-b-blue-600 dark:[&.active]:border-b-blue-400 [&.active]:text-blue-600 dark:[&.active]:text-blue-400 whitespace-nowrap"
    >
      {{@label}}
    </LinkTo>
  </li>
</template>;

<template>
  <ul
    id="nav"
    class="flex justify-center border-b border-neutral-300 dark:border-neutral-700 space-x-3 -mb-px"
  >
    <NavItem @route="index" @label={{t "tabs.repositories"}} />
    <NavItem @route="articles" @label={{t "tabs.articles"}} />
  </ul>
</template>
