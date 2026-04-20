import type { TOC } from '@ember/component/template-only';
import { formatDate } from 'ember-intl';
import { pageTitle } from 'ember-page-title';

interface ArticlesSignature {
  Args: {
    model: unknown;
    controller: unknown;
  };
}

<template>
  {{pageTitle "Articles"}}

  <div class="flex flex-col gap-8 max-w-2xl mx-auto">
    {{#each @model as |article|}}
      <div>
        <h2 class="text-xl font-bold mb-2">{{article.title}}</h2>
        <p class="text-neutral-500 dark:text-neutral-400 mb-2">
          {{formatDate article.createdAt dateStyle="long"}}
        </p>
        <p class="mb-2">{{article.description}}</p>
        <a
          href={{article.url}}
          target="_blank"
          rel="noopener noreferrer"
          class="text-blue-600 dark:text-blue-400 underline"
        >
          Read article
        </a>
      </div>

    {{/each}}
  </div>
</template> satisfies TOC<ArticlesSignature>;
