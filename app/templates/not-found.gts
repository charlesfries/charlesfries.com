import type { TOC } from '@ember/component/template-only';
import { LinkTo } from '@ember/routing';
import { pageTitle } from 'ember-page-title';

interface NotFoundSignature {
  Args: {
    model: unknown;
    controller: unknown;
  };
}

<template>
  {{pageTitle "Not Found"}}

  <div class="text-center mt-10">
    <h1 class="text-4xl font-bold">404</h1>
    <p class="mt-4">Page not found.</p>

    <LinkTo @route="index" class="mt-6 inline-block text-blue-500 underline">
      Go home
    </LinkTo>
  </div>
</template> satisfies TOC<NotFoundSignature>;
