import type { TOC } from '@ember/component/template-only';
import { pageTitle } from 'ember-page-title';

interface ArticlesSignature {
  Args: {
    model: unknown;
    controller: unknown;
  };
}

<template>
  {{pageTitle "Articles"}}

  Articles
</template> satisfies TOC<ArticlesSignature>;
