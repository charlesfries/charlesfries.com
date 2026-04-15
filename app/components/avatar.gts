import { t } from 'ember-intl';

<template>
  <div
    class="avatar w-42 p-1 rounded-full bg-linear-to-tr from-yellow-400 via-pink-500 to-purple-600"
  >
    <img
      src="avatar.png"
      alt={{t "name"}}
      class="w-full rounded-full object-cover border-3 border-white dark:border-black"
    />
  </div>
</template>
