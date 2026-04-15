import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { render } from '@ember/test-helpers';
import ErrorComponent from 'charlesfries/components/error';

module('Integration | Component | error', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    const error = new Error('This is an error message.');

    await render(
      <template>
        <ErrorComponent @error={{error}} @message="This is a message." />
      </template>,
    );

    assert.dom().hasText('This is a message.');
  });
});
