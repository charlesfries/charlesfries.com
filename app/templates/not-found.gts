import { LinkTo } from '@ember/routing';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import { faArrowRotateLeft } from '@fortawesome/free-solid-svg-icons';
import { BUTTON } from 'charlesfries/utils/class-names';
import { t } from 'ember-intl';
import { pageTitle } from 'ember-page-title';

<template>
  {{pageTitle (t "notFound.title")}}

  <div class="text-center mt-10">
    <img
      src="not-found.png"
      alt={{t "notFound.title"}}
      class="w-sm rounded-2xl mx-auto mb-8"
    />
    <h2 class="text-4xl font-bold">{{t "notFound.title"}}</h2>
    <p class="text-neutral-500 dark:text-neutral-400 mt-4">
      {{t "notFound.message"}}
    </p>
    <LinkTo @route="repositories" class="{{BUTTON.primary}} inline-block mt-6">
      <FaIcon @icon={{faArrowRotateLeft}} class="mr-1" />
      {{t "notFound.goHome"}}
    </LinkTo>
  </div>
</template>
