import Avatar from 'charlesfries/components/avatar';
import Description from 'charlesfries/components/description';
import Heading from 'charlesfries/components/heading';
import LocaleSelect from 'charlesfries/components/locale-select';
import Nav from 'charlesfries/components/nav';
import Socials from 'charlesfries/components/socials';
import ThemeButton from 'charlesfries/components/theme-button';
import { t } from 'ember-intl';
import { pageTitle } from 'ember-page-title';

<template>
  {{pageTitle "Charles Fries"}}

  <div class="container mx-auto px-4 py-12">
    <header
      class="flex flex-col items-center gap-8 max-w-lg mx-auto text-center mb-8"
    >
      <Avatar />
      <Heading />
      <div class="flex gap-2">
        <LocaleSelect />
        <ThemeButton />
      </div>
      <Description />
      <Socials />
      <Nav />
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
