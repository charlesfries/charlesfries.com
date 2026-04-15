import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { render } from '@ember/test-helpers';
import Error from 'charlesfries/components/error';

module('Integration | Component | error', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template><Error @message="This is a message." /></template>);

    assert.dom().hasText('This is a message.');
  });
});
