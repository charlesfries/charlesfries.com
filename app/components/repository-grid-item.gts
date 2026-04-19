import type { TOC } from '@ember/component/template-only';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import { faCodeFork, faStar } from '@fortawesome/free-solid-svg-icons';
import type { Repository } from 'charlesfries/schemas/repository';
import { formatDate, t } from 'ember-intl';
import Card from './card';

export const languageColors: Record<string, string> = {
  JavaScript: 'text-yellow-700 dark:text-yellow-300',
  TypeScript: 'text-blue-600 dark:text-blue-400',
  Python: 'text-blue-400',
  Java: 'text-orange-500',
  C: 'text-gray-500',
  'C++': 'text-blue-600',
  'C#': 'text-green-600',
  'Objective-C': 'text-blue-500',
  Go: 'text-cyan-700 dark:text-cyan-300',
  Rust: 'text-orange-600',
  Ruby: 'text-red-600',
  PHP: 'text-indigo-400',
  Swift: 'text-orange-400',
  Kotlin: 'text-purple-500',
  Dart: 'text-blue-400',
  Scala: 'text-red-500',
  Shell: 'text-green-500',
  PowerShell: 'text-blue-700',
  HTML: 'text-orange-600',
  CSS: 'text-blue-300',
  SCSS: 'text-pink-400',
  Less: 'text-blue-500',
  JSON: 'text-gray-400',
  YAML: 'text-red-400',
  Markdown: 'text-gray-600',
  GraphQL: 'text-pink-500',
  SQL: 'text-blue-700',
  Dockerfile: 'text-blue-500',
  Makefile: 'text-gray-500',
};

const getLanguageColor = (language: string) =>
  languageColors[language] ?? 'text-neutral-400';

export interface RepositoryGridItemSignature {
  repository: Repository;
}

<template>
  <Card
    class="relative hover:border-blue-500 hover:shadow transition-shadow duration-300"
  >
    <a
      href={{@repository.url}}
      class="text-blue-600 dark:text-blue-400 underline after:absolute after:inset-0"
    >
      {{@repository.name}}
    </a>
    {{#if @repository.isFork}}
      <FaIcon @icon={{faCodeFork}} class="text-neutral-300" />
    {{/if}}
    <div class="mt-1">
      {{#if @repository.description}}
        {{@repository.description}}
      {{else}}
        <span class="italic">{{t "noDescription"}}</span>
      {{/if}}
    </div>
    <div class="flex gap-2 mt-1">
      {{#if @repository.primaryLanguage}}
        <span
          class="font-bold
            {{getLanguageColor @repository.primaryLanguage.name}}"
        >
          {{@repository.primaryLanguage.name}}
        </span>
      {{/if}}
      <div>
        <FaIcon @icon={{faStar}} class="text-neutral-300" />
        <span class="text-neutral-500 dark:text-neutral-400">
          {{@repository.stargazerCount}}
        </span>
      </div>
      <div>
        <FaIcon @icon={{faCodeFork}} class="text-neutral-300" />
        <span class="text-neutral-500 dark:text-neutral-400">
          {{@repository.forkCount}}
        </span>
      </div>
    </div>
    <div class="text-sm text-neutral-500 dark:text-neutral-400 mt-2">
      {{t "updated"}}
      {{formatDate @repository.pushedAt year="numeric" month="long"}}
    </div>
  </Card>
</template> satisfies TOC<RepositoryGridItemSignature>;
