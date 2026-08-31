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

    assert.dom('#card span').exists('it yields content');
    assert
      .dom('#card')
      .hasClass('rounded-xl', 'it applies default card styling');
  });

  test('it forwards attributes to the element', async function (assert) {
    await render(
      <template>
        <Card data-test-card class="extra-class">
          <span></span>
        </Card>
      </template>,
    );

    assert
      .dom('#card')
      .hasAttribute('data-test-card', '', 'it forwards arbitrary attributes');
    assert.dom('#card').hasClass('extra-class', 'it merges passed-in class');
  });
});
