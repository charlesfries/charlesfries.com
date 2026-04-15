import type { TOC } from '@ember/component/template-only';
import { pageTitle } from 'ember-page-title';

interface NotFoundSignature {
  Args: {
    model: unknown;
    controller: unknown;
  };
}

<template>
  {{pageTitle "Not Found"}}

  Not Found
</template> satisfies TOC<NotFoundSignature>;
