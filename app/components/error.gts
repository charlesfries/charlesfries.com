import type { TOC } from '@ember/component/template-only';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import { faTriangleExclamation } from '@fortawesome/free-solid-svg-icons';

export interface ErrorSignature {
  Args: {
    error: Error;
    message: string;
  };
  Element: HTMLDivElement;
}

<template>
  <div class="bg-red-500 text-white rounded-lg p-4" role="alert" ...attributes>
    <FaIcon @icon={{faTriangleExclamation}} class="mr-1" />
    {{@message}}
  </div>
</template> satisfies TOC<ErrorSignature>;
