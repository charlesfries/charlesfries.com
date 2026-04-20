import type { TOC } from '@ember/component/template-only';
import { LinkTo } from '@ember/routing';
import Avatar from 'charlesfries/components/avatar';
import Description from 'charlesfries/components/description';
import Heading from 'charlesfries/components/heading';
import LocaleSelect from 'charlesfries/components/locale-select';
import Socials from 'charlesfries/components/socials';
import ThemeButton from 'charlesfries/components/theme-button';
import { t } from 'ember-intl';
import { pageTitle } from 'ember-page-title';

const Tab: TOC<{ route: string; label: string }> = <template>
  <li>
    <LinkTo
      @route={{@route}}
      class="inline-block py-4 px-6 text-gray-500 hover:text-gray-800 font-medium border-b-2 border-transparent [&.active]:border-b-indigo-600 [&.active]:text-indigo-600 whitespace-nowrap"
    >
      {{@label}}
      {{! <span class="bg-indigo-50 py-1 px-2 rounded-full ml-2 text-xs">New</span> }}
    </LinkTo>
  </li>
</template>;

<template>
  {{pageTitle "Charles Fries"}}

  <div class="container mx-auto px-4 py-12">
    <header class="flex flex-col items-center gap-8 max-w-lg mx-auto mb-8">
      <Avatar />
      <Heading />
      <div class="flex gap-2">
        <LocaleSelect />
        <ThemeButton />
      </div>
      <Description />
      <Socials />
      <ul
        class="flex justify-center border-b border-neutral-300 space-x-3 transition-all duration-300 -mb-px"
      >
        <Tab @route="index" @label="Repositories" />
        <Tab @route="articles" @label="Articles" />
      </ul>
    </header>
    <main>
      {{outlet}}
    </main>
    <footer
      class="border-t border-neutral-300 dark:border-neutral-700 text-center text-neutral-500 dark:text-neutral-400 mt-10 pt-4"
    >
      {{t "copyright"}}
    </footer>
  </div>
</template>
