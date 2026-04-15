import Avatar from 'charlesfries/components/avatar';
import Heading from 'charlesfries/components/heading';
import Locale from 'charlesfries/components/locale';
import Theme from 'charlesfries/components/theme';
import { t } from 'ember-intl';
import { pageTitle } from 'ember-page-title';

<template>
  {{pageTitle "Charles Fries"}}

  <div class="container mx-auto px-4 py-12">
    <header class="flex flex-col items-center mb-8">
      <div class="flex flex-col items-center gap-8 max-w-lg">
        <Avatar />
        <Heading />
        <div class="flex gap-2">
          <Locale />
          <Theme />
        </div>
      </div>
    </header>
    <main>
      {{outlet}}
    </main>
    <footer
      class="border-t border-neutral-300 text-center text-neutral-500 mt-10 pt-4"
    >
      {{t "copyright"}}
    </footer>
  </div>
</template>
