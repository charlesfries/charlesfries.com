import type { TOC } from '@ember/component/template-only';
import { LinkTo } from '@ember/routing';
import { t } from 'ember-intl';
import { pageTitle } from 'ember-page-title';

interface NotFoundSignature {
  Args: {
    model: unknown;
    controller: unknown;
  };
}

<template>
  {{pageTitle (t "notFound.title")}}

  <div class="text-center mt-10">
    <h1 class="text-4xl font-bold">{{t "notFound.title"}}</h1>
    <p class="mt-4">{{t "notFound.message"}}</p>
    <LinkTo
      @route="repositories"
      class="mt-6 inline-block text-blue-500 underline"
    >
      {{t "notFound.goHome"}}
    </LinkTo>
  </div>
</template> satisfies TOC<NotFoundSignature>;
