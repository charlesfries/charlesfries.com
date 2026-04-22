import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { render, select } from '@ember/test-helpers';
import LocaleSelect from 'charlesfries/components/locale-select';

module('Integration | Component | locale-select', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    const intl = this.owner.lookup('service:intl');

    await render(<template><LocaleSelect /></template>);

    assert.dom().hasText('English 中文 Español Français Italiano');
    assert.dom('select').exists();

    assert.strictEqual(intl.primaryLocale, 'en-us', 'it defaults to en-us');

    await select('select', 'zh-cn');

    assert.strictEqual(intl.primaryLocale, 'zh-cn', 'it updates locale');
  });
});
