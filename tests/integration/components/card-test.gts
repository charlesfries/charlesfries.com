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
          <span></span>
        </Card>
      </template>,
    );

    assert.dom('div span').exists();
  });
});
