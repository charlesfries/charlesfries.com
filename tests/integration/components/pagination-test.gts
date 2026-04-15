import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { render } from '@ember/test-helpers';
import Pagination from 'charlesfries/components/pagination';

module('Integration | Component | pagination', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    const meta = {
      hasMore: false,
      first: null,
      last: null,
    };

    await render(
      <template><Pagination @meta={{meta}} @isBackward={{null}} /></template>,
    );

    assert.dom().hasText('');
  });
});
