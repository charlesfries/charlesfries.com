import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { render } from '@ember/test-helpers';
import RepositoryGridItem from 'charlesfries/components/repository-grid-item';
import type { Repository } from 'charlesfries/schemas/repository';

module('Integration | Component | repository-grid-item', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    const repository = {
      name: 'Name',
      description: 'This is a description.',
      url: 'https://github.com/',
      stargazerCount: 1,
      forkCount: 2,
      isFork: false,
      pushedAt: new Date(2026, 0, 1).toISOString(),
      primaryLanguage: {
        name: 'TypeScript',
      },
    } as Repository;

    await render(
      <template><RepositoryGridItem @repository={{repository}} /></template>,
    );

    assert
      .dom()
      .hasText(
        'Name This is a description. TypeScript 1 2 Updated on January 2026',
      );
    assert
      .dom('a')
      .hasAttribute('href', 'https://github.com/', 'it links to the repo');
    assert
      .dom('.fa-code-fork')
      .exists(
        { count: 1 },
        'it only shows the fork-count icon, not the is-fork indicator',
      );
  });

  test('it shows a fork icon for forked repositories', async function (assert) {
    const repository = {
      name: 'Name',
      description: 'This is a description.',
      url: 'https://github.com/',
      stargazerCount: 1,
      forkCount: 2,
      isFork: true,
      pushedAt: new Date(2026, 0, 1).toISOString(),
      primaryLanguage: {
        name: 'TypeScript',
      },
    } as Repository;

    await render(
      <template><RepositoryGridItem @repository={{repository}} /></template>,
    );

    assert
      .dom('.fa-code-fork')
      .exists(
        { count: 2 },
        'it shows both the is-fork indicator and the fork-count icon',
      );
  });

  test('it shows a fallback when there is no description', async function (assert) {
    const repository = {
      name: 'Name',
      description: '',
      url: 'https://github.com/',
      stargazerCount: 1,
      forkCount: 2,
      isFork: false,
      pushedAt: new Date(2026, 0, 1).toISOString(),
      primaryLanguage: {
        name: 'TypeScript',
      },
    } as Repository;

    await render(
      <template><RepositoryGridItem @repository={{repository}} /></template>,
    );

    assert
      .dom()
      .includesText('No description', 'it shows a fallback description');
  });

  test('it hides the language when there is none', async function (assert) {
    const repository = {
      name: 'Name',
      description: 'This is a description.',
      url: 'https://github.com/',
      stargazerCount: 1,
      forkCount: 2,
      isFork: false,
      pushedAt: new Date(2026, 0, 1).toISOString(),
      primaryLanguage: null,
    } as unknown as Repository;

    await render(
      <template><RepositoryGridItem @repository={{repository}} /></template>,
    );

    assert
      .dom()
      .hasText(
        'Name This is a description. 1 2 Updated on January 2026',
        'it omits the language',
      );
  });

  test('it falls back to a neutral color for unknown languages', async function (assert) {
    const repository = {
      name: 'Name',
      description: 'This is a description.',
      url: 'https://github.com/',
      stargazerCount: 1,
      forkCount: 2,
      isFork: false,
      pushedAt: new Date(2026, 0, 1).toISOString(),
      primaryLanguage: {
        name: 'Brainfuck',
      },
    } as Repository;

    await render(
      <template><RepositoryGridItem @repository={{repository}} /></template>,
    );

    assert
      .dom('span.font-bold')
      .hasClass('text-neutral-400', 'it uses the fallback color');
  });
});
