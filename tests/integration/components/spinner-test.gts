import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { render } from '@ember/test-helpers';
import Spinner from 'charlesfries/components/spinner';

module('Integration | Component | spinner', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template><Spinner /></template>);

    assert.dom('svg').exists('it shows svg');
  });
});
