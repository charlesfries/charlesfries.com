import type { TOC } from '@ember/component/template-only';
import { Request } from '@warp-drive/ember';
import Card from 'charlesfries/components/card';
import ErrorAlert from 'charlesfries/components/error-alert';
import Spinner from 'charlesfries/components/spinner';
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
      <Spinner class="mx-auto" />
    </:loading>

    <:error as |error|>
      <ErrorAlert @error={{error}} @message={{t "error"}} />
    </:error>

    <:content as |content|>
      <div class="flex flex-col gap-4 max-w-lg mx-auto">
        {{#each content.data as |article|}}
          <Card
            class="hover:border-blue-500 hover:shadow transition-shadow duration-300"
          >
            <h2
              class="text-blue-600 dark:text-blue-400 underline mb-2"
            >{{article.title}}</h2>
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
          </Card>
        {{/each}}
      </div>
    </:content>
  </Request>
</template> satisfies TOC<ArticlesSignature>;
