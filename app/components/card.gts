import type { TOC } from '@ember/component/template-only';

export interface CardSignature {
  Blocks: {
    default: [];
  };
  Element: HTMLDivElement;
}

<template>
  <div
    id="card"
    class="bg-white dark:bg-neutral-950 border border-neutral-300 dark:border-neutral-700 rounded-xl p-4"
    ...attributes
  >
    {{yield}}
  </div>
</template> satisfies TOC<CardSignature>;
