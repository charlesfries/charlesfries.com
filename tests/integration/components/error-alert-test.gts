import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { click, render } from '@ember/test-helpers';
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

    assert.dom('#error-alert').hasAttribute('role', 'alert', 'it is an alert');
    assert.dom('p').hasText('This is a message.', 'it shows message');
    assert.dom('button').hasText('Show details', 'it shows button text');
    assert.dom('button + p').doesNotExist('it hides error details by default');

    await click('button');

    assert.dom('button').hasText('Hide details', 'it flips button text');
    assert
      .dom('button + p')
      .hasText('This is an error message.', 'it shows error message');

    await click('button');

    assert.dom('button').hasText('Show details', 'it flips button text back');
    assert.dom('button + p').doesNotExist('it hides error details again');
  });

  test('it forwards attributes to the element', async function (assert) {
    const error = new Error('This is an error message.');

    await render(
      <template>
        <ErrorAlert
          @error={{error}}
          @message="This is a message."
          data-test-error-alert
        />
      </template>,
    );

    assert
      .dom('#error-alert')
      .hasAttribute('data-test-error-alert', '', 'it forwards attributes');
  });
});
