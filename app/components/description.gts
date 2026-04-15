import { t } from 'ember-intl';

<template>
  <p class="text-center">{{t "description" name=(t "name") htmlSafe=true}}</p>
</template>
