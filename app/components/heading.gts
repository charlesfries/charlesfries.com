import { t } from 'ember-intl';

<template>
  <style>
    @keyframes color-foreground-rotate {
      0% {
        color: #3556e3;
      }
      20% {
        color: #1c9b40;
      }
      40% {
        color: #d67a09;
      }
      60% {
        color: #e01e1e;
      }
      80% {
        color: #ae2af4;
      }
      100% {
        color: #3556e3;
      }
    }

    .heading {
      font-family: Yesteryear, cursive;
      animation: color-foreground-rotate 2s linear infinite;
    }
  </style>

  <h1 class="heading text-8xl font-bold italic">{{t "name"}}</h1>
</template>
