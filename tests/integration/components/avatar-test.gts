import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { render } from '@ember/test-helpers';
import Avatar from 'charlesfries/components/avatar';

module('Integration | Component | avatar', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template><Avatar /></template>);

    assert.dom('#avatar img').exists('it shows image');
    assert
      .dom('#avatar img')
      .hasAttribute('src', 'avatar.png', 'it has correct image source');
    assert
      .dom('#avatar img')
      .hasAttribute('alt', 'Charles Fries', 'it has correct alt text');
  });
});
