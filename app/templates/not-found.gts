import { LinkTo } from '@ember/routing';
import { t } from 'ember-intl';
import { pageTitle } from 'ember-page-title';
import { PRIMARY_BUTTON_CLASS_NAME } from './repositories/index';

<template>
  {{pageTitle (t "notFound.title")}}

  <div class="text-center mt-10">
    <img
      src="not-found.png"
      alt={{t "notFound.title"}}
      class="w-sm rounded-2xl mx-auto mb-8"
    />
    <h2 class="text-4xl font-bold">{{t "notFound.title"}}</h2>
    <p class="text-neutral-500 mt-4">{{t "notFound.message"}}</p>
    <LinkTo
      @route="repositories"
      class="{{PRIMARY_BUTTON_CLASS_NAME}} inline-block mt-4"
    >
      {{t "notFound.goHome"}}
    </LinkTo>
  </div>
</template>
