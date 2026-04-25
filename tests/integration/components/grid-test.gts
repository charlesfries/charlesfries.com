import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { render } from '@ember/test-helpers';
import Grid from 'charlesfries/components/grid';

module('Integration | Component | grid', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(
      <template>
        <Grid>
          <span></span>
        </Grid>
      </template>,
    );

    assert.dom('#grid span').exists('it yields content');
  });
});
