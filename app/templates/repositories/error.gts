import type { TOC } from '@ember/component/template-only';
import Error from 'charlesfries/components/error';
import { t } from 'ember-intl';

interface RepositoriesErrorSignature {
  Args: {
    model: Error;
    controller: unknown;
  };
}

<template>
  <Error @error={{@model}} @message={{t "error"}} />
</template> satisfies TOC<RepositoriesErrorSignature>;
