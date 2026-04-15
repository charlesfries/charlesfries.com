import type Owner from '@ember/owner';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import MarkdownToHtml from 'ember-cli-showdown/components/markdown-to-html';
import { eq } from 'ember-truth-helpers';

type State =
  | { status: 'loading' }
  | { status: 'error'; error: unknown }
  | { status: 'success'; data: string };

export default class Technologies extends Component {
  @tracked state: State = { status: 'loading' };

  constructor(owner: Owner, args: never) {
    super(owner, args);

    void this.load();
  }

  load = async () => {
    try {
      // eslint-disable-next-line warp-drive/no-external-request-patterns
      const response = await fetch(
        'https://raw.githubusercontent.com/charlesfries/charlesfries/master/README.md',
      );
      if (!response.ok) {
        throw new Error('not ok');
      }
      const data = await response.text();
      this.state = { status: 'success', data };
    } catch (error) {
      this.state = { status: 'error', error };
    }
  };

  <template>
    {{! template-lint-disable no-forbidden-elements }}
    <style>
      .readme h3 {
        display: none;
      }
      .readme img {
        display: inline;
      }
    </style>

    {{#if (eq "loading" this.state.status)}}
      <div class="mx-auto">
        <svg
          class="size-5 animate-spin text-black"
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
        >
          <circle
            class="opacity-25"
            cx="12"
            cy="12"
            r="10"
            stroke="currentColor"
            stroke-width="4"
          ></circle>
          <path
            class="opacity-75"
            fill="currentColor"
            d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
          ></path>
        </svg>
      </div>
    {{else if (eq "error" this.state.status)}}
      <span>Error</span>
    {{else if (eq "success" this.state.status)}}
      <MarkdownToHtml @markdown={{this.state.data}} class="readme" />
    {{/if}}
  </template>
}
