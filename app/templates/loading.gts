import Grid from 'charlesfries/components/grid';
import Placeholder from 'charlesfries/components/placeholder';
import RateLimit from 'charlesfries/components/rate-limit';

const range = (length: number) => new Array<void>(length);

<template>
  <style>
    .vertical-fade {
      mask-image: linear-gradient(to bottom, black 0%, transparent 100%);
    }
  </style>

  <RateLimit @remaining={{null}} @max={{null}} @resetAt={{null}} />
  <Grid class="vertical-fade">
    {{#each (range 32)}}
      <Placeholder />
    {{/each}}
  </Grid>
</template>
