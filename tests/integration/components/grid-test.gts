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
    assert.dom('#grid').hasClass('grid', 'it applies default grid styling');
  });

  test('it forwards attributes to the element', async function (assert) {
    await render(
      <template>
        <Grid data-test-grid class="extra-class">
          <span></span>
        </Grid>
      </template>,
    );

    assert
      .dom('#grid')
      .hasAttribute('data-test-grid', '', 'it forwards arbitrary attributes');
    assert.dom('#grid').hasClass('extra-class', 'it merges passed-in class');
  });
});
