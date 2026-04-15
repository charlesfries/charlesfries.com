import type Owner from '@ember/owner';
import { service } from '@ember/service';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import { faTriangleExclamation } from '@fortawesome/free-solid-svg-icons';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { SkipCache } from '@warp-drive/core/types/request';
import type { TextBody } from 'charlesfries/handlers/text';
import type Store from 'charlesfries/services/store';
import MarkdownToHtml from 'ember-cli-showdown/components/markdown-to-html';

const eq = (a: unknown, b: unknown) => a === b;

type State =
  | { status: 'loading' }
  | { status: 'error'; error: unknown }
  | { status: 'success'; data: string };

export default class Technologies extends Component {
  @service declare store: Store;

  @tracked state: State = { status: 'loading' };

  constructor(owner: Owner, args: never) {
    super(owner, args);

    void this.load();
  }

  load = async () => {
    await new Promise((resolve) => setTimeout(resolve, 2000));

    try {
      const { content } = await this.store.request<TextBody>({
        url: 'https://raw.githubusercontent.com/charlesfries/charlesfries/master/README.md',
        headers: new Headers({ Accept: 'text/plain' }),
        cacheOptions: {
          [SkipCache]: true,
        },
      });
      this.state = { status: 'success', data: content.text };
    } catch (error) {
      this.state = { status: 'error', error };
    }
  };

  <template>
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
          class="size-5 animate-spin text-black dark:text-white"
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
      <div
        class="self-center bg-red-500 text-white rounded-lg p-4"
        role="alert"
      >
        <FaIcon @icon={{faTriangleExclamation}} class="mr-1" />
        Couldn't fetch GitHub README!
      </div>
    {{else if (eq "success" this.state.status)}}
      <MarkdownToHtml @markdown={{this.state.data}} class="readme" />
    {{/if}}
  </template>
}
