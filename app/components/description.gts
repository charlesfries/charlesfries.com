import { t } from 'ember-intl';

<template>
  <p id="description">{{t "description" name=(t "name") htmlSafe=true}}</p>
</template>
