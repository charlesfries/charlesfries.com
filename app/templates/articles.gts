import type { TOC } from '@ember/component/template-only';
import type ArticlesRoute from 'charlesfries/routes/articles';
import { formatDate } from 'ember-intl';
import { pageTitle } from 'ember-page-title';
import type { ModelFrom } from './index.gts';

interface ArticlesSignature {
  Args: {
    model: ModelFrom<ArticlesRoute>;
    controller: unknown;
  };
}

<template>
  {{pageTitle "Articles"}}

  <div class="flex flex-col gap-8 max-w-2xl mx-auto">
    {{#each @model.content.data as |article|}}
      <div>
        <h2 class="text-xl font-bold mb-2">{{article.title}}</h2>
        <p class="text-neutral-500 dark:text-neutral-400 mb-2">
          {{formatDate article.published_at dateStyle="long"}}
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
