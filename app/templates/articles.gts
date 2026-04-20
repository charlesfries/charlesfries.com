import type { TOC } from '@ember/component/template-only';
import { Request } from '@warp-drive/ember';
import ErrorAlert from 'charlesfries/components/error-alert';
import type ArticlesRoute from 'charlesfries/routes/articles';
import { formatDate, t } from 'ember-intl';
import { pageTitle } from 'ember-page-title';
import type { ModelFrom } from './index';

interface ArticlesSignature {
  Args: {
    model: ModelFrom<ArticlesRoute>;
    controller: unknown;
  };
}

<template>
  {{pageTitle "Articles"}}

  <Request @request={{@model.request}}>
    <:loading>
      Loading
    </:loading>

    <:error as |error|>
      <ErrorAlert @error={{error}} @message={{t "error"}} />
    </:error>

    <:content as |content|>
      <div class="flex flex-col gap-8 max-w-2xl mx-auto">
        {{#each content.data as |article|}}
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
    </:content>
  </Request>
</template> satisfies TOC<ArticlesSignature>;
