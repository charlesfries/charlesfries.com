import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { render } from '@ember/test-helpers';
import Card from 'charlesfries/components/card';

module('Integration | Component | card', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(
      <template>
        <Card>
          template block text
        </Card>
      </template>,
    );

    assert.dom().hasText('template block text');
  });
});
