import { on } from '@ember/modifier';
import { service } from '@ember/service';
import Component from '@glimmer/component';
import { SkipCache } from '@warp-drive/core/types/request';
import { Request } from '@warp-drive/ember';
import Error from 'charlesfries/components/error';
import type { TextBody } from 'charlesfries/handlers/text';
import type Store from 'charlesfries/services/store';
import MarkdownToHtml from 'ember-cli-showdown/components/markdown-to-html';

const Spinner = <template>
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
</template>;

export default class Technologies extends Component {
  @service declare store: Store;

  get request() {
    return this.store.request<TextBody>({
      url: 'https://raw.githubusercontent.com/charlesfries/charlesfries/master/README.md',
      headers: new Headers({ Accept: 'text/plain' }),
      cacheOptions: {
        [SkipCache]: true,
      },
    });
  }

  <template>
    {{! template-lint-disable no-bare-strings no-log  }}

    <style>
      .readme h3 {
        display: none;
      }

      .readme img {
        display: inline;
      }
    </style>

    <Request @request={{this.request}}>
      <:loading as |state|>
        <Spinner />
        <button type="button" {{on "click" state.abort}}>Cancel</button>
      </:loading>

      <:error as |error state|>
        <Error @message="Couldn't fetch GitHub README!" />
        <button type="button" {{on "click" state.retry}}>Retry</button>
      </:error>

      <:content as |content state|>
        <MarkdownToHtml @markdown={{content.text}} class="readme text-center" />
        <button type="button" {{on "click" state.refresh}}>Refresh</button>
        <button type="button" {{on "click" state.reload}}>Reload</button>
      </:content>

      <:cancelled as |error state|>
        <p>Cancelled</p>
        <button type="button" {{on "click" state.retry}}>Retry</button>
      </:cancelled>
    </Request>
  </template>
}
