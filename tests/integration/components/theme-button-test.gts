import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { render } from '@ember/test-helpers';
import ThemeButton from 'charlesfries/components/theme-button';

module('Integration | Component | theme-button', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template><ThemeButton /></template>);

    assert.dom().hasText('');
  });
});
