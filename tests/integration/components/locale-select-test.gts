import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { render, select } from '@ember/test-helpers';
import LocaleSelect from 'charlesfries/components/locale-select';
import mixpanel from 'mixpanel-browser';

module('Integration | Component | locale-select', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    const intl = this.owner.lookup('service:intl');

    await render(<template><LocaleSelect /></template>);

    assert.dom().hasText('English 中文 Español Français Italiano');
    assert.dom('select').exists();
    assert.dom('select').hasAttribute('aria-label', 'Locale');
    assert.dom('select option').exists({ count: 5 }, 'it shows every locale');
    assert
      .dom('select option:first-child')
      .hasAttribute('value', 'en-us', 'it lists locales in order');

    assert.strictEqual(intl.primaryLocale, 'en-us', 'it defaults to en-us');

    await select('select', 'zh-cn');

    assert.strictEqual(intl.primaryLocale, 'zh-cn', 'it updates locale');
  });

  test('it tracks locale changes in mixpanel', async function (assert) {
    // eslint-disable-next-line @typescript-eslint/unbound-method -- restored below, never called unbound
    const original = mixpanel.track;
    let trackedArgs: unknown[] = [];
    mixpanel.track = (...args: unknown[]) => {
      trackedArgs = args;
    };

    try {
      await render(<template><LocaleSelect /></template>);

      await select('select', 'fr-fr');

      assert.deepEqual(
        trackedArgs,
        ['Locale Changed', { locale: 'fr-fr' }],
        'it tracks the new locale',
      );
    } finally {
      mixpanel.track = original;
    }
  });
});
