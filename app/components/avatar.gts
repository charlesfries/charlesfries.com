import { t } from 'ember-intl';

<template>
  <div
    class="size-42 p-1 rounded-full bg-linear-to-tr from-yellow-400 via-pink-500 to-purple-600 mx-auto"
  >
    <img
      src="https://avatars.githubusercontent.com/u/2275005?v=4"
      alt={{t "name"}}
      class="w-full rounded-full object-cover border-3 border-white dark:border-black"
    />
  </div>
</template>
