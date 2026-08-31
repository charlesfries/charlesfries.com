import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { render } from '@ember/test-helpers';
import Description from 'charlesfries/components/description';

module('Integration | Component | description', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template><Description /></template>);

    assert.dom('#description').exists('it shows text');
    assert
      .dom('#description')
      .includesText('My name is Charles Fries.', 'it interpolates the name');
    assert
      .dom('#description strong')
      .exists(
        { count: 4 },
        'it renders the html-safe markup instead of escaping it',
      );
  });
});
