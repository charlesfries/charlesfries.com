import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { click, render } from '@ember/test-helpers';
import Toolbar from 'charlesfries/components/toolbar';

module('Integration | Component | toolbar', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    const refresh = () => {
      assert.ok(true, 'it calls refresh');
    };

    await render(
      <template>
        <Toolbar @isLoading={{false}} @onRefresh={{refresh}} />
      </template>,
    );

    assert.dom().hasText('Created Updated Pushed Name All Sources Forks');
    assert.dom('#refresh').isNotDisabled('it is enabled when not loading');

    await click('#refresh');

    assert
      .dom('a[aria-label="Sort descending"] svg')
      .exists('it shows a descending sort icon');
    assert
      .dom('a[aria-label="Sort ascending"] svg')
      .exists('it shows an ascending sort icon');
  });

  test('it disables refresh while loading', async function (assert) {
    const refresh = () => {};

    await render(
      <template>
        <Toolbar @isLoading={{true}} @onRefresh={{refresh}} />
      </template>,
    );

    assert.dom('#refresh').isDisabled('it is disabled while loading');
    assert
      .dom('#refresh')
      .hasAria(
        'label',
        'Refresh',
        'it keeps a label for assistive tech even while disabled',
      );
  });
});
