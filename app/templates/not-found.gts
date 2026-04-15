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
  {{pageTitle "Not found"}}

  <div class="text-center mt-10">
    <h1 class="text-4xl font-bold">Page not found</h1>
    <p class="mt-4">This page could not be found.</p>
    <LinkTo
      @route="repositories"
      class="mt-6 inline-block text-blue-500 underline"
    >
      Go home
    </LinkTo>
  </div>
</template> satisfies TOC<NotFoundSignature>;
