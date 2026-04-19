import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { render } from '@ember/test-helpers';
import RateLimitAlert from 'charlesfries/components/rate-limit-alert';

module('Integration | Component | rate-limit-alert', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(
      <template>
        <RateLimitAlert @remaining={{null}} @max={{null}} @resetAt={{null}} />
      </template>,
    );

    assert.dom().hasText('');
  });
});
