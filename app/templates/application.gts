import Avatar from 'charlesfries/components/avatar';
import Heading from 'charlesfries/components/heading';
import LocaleSelect from 'charlesfries/components/locale-select';
import ThemeButton from 'charlesfries/components/theme-button';
import { t } from 'ember-intl';
import { pageTitle } from 'ember-page-title';

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
