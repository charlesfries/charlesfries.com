declare module 'ember-cli-showdown/components/markdown-to-html' {
  import type Component from '@glimmer/component';

  export default class MarkdownToHtml extends Component<{
    Args: {
      markdown: string;
    };
    Element: HTMLDivElement;
  }> {}
}
