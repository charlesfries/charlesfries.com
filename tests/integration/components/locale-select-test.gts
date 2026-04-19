import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { render } from '@ember/test-helpers';
import LocaleSelect from 'charlesfries/components/locale-select';

module('Integration | Component | locale-select', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template><LocaleSelect /></template>);

    assert.dom().hasText('English 中文 Español Français Italiano');
    assert.dom('select').exists();
  });
});
