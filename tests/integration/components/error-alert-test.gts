import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { render } from '@ember/test-helpers';
import ErrorAlert from 'charlesfries/components/error-alert';

module('Integration | Component | error-alert', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    const error = new Error('This is an error message.');

    await render(
      <template>
        <ErrorAlert @error={{error}} @message="This is a message." />
      </template>,
    );

    assert.dom().hasText('This is a message.');
  });
});
