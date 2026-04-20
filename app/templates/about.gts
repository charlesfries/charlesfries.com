import type { TOC } from '@ember/component/template-only';
import { pageTitle } from 'ember-page-title';

interface AboutSignature {
  Args: {
    model: unknown;
    controller: unknown;
  };
}

<template>
  {{pageTitle "About"}}
  {{outlet}}
</template> satisfies TOC<AboutSignature>;
