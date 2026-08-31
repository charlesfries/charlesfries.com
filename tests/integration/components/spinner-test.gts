import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { render } from '@ember/test-helpers';
import Spinner from 'charlesfries/components/spinner';

module('Integration | Component | spinner', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template><Spinner /></template>);

    assert.dom('svg').exists('it shows svg');
    assert.dom('#spinner').hasClass('animate-spin', 'it spins');
    assert.dom('#spinner circle').exists('it shows the track');
    assert.dom('#spinner path').exists('it shows the spinning arc');
  });

  test('it forwards attributes to the element', async function (assert) {
    await render(<template><Spinner data-test-spinner /></template>);

    assert
      .dom('#spinner')
      .hasAttribute('data-test-spinner', '', 'it forwards attributes');
  });
});
