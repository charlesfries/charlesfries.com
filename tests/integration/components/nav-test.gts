import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { render } from '@ember/test-helpers';
import Nav from 'charlesfries/components/nav';

module('Integration | Component | nav', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template><Nav /></template>);

    assert.dom().hasText('Repositories Articles');
    assert.dom('#nav li').exists({ count: 2 }, 'it shows two tabs');
    assert
      .dom('#nav li:first-child a')
      .hasText('Repositories', 'it lists repositories first');
    assert
      .dom('#nav li:last-child a')
      .hasText('Articles', 'it lists articles second');
  });
});
