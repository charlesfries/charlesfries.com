import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { click, render, rerender } from '@ember/test-helpers';
import ThemeButton from 'charlesfries/components/theme-button';

module('Integration | Component | theme-button', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    localStorage.setItem('theme', 'light');

    await render(<template><ThemeButton /></template>);

    assert.dom().hasText('');

    assert.dom('#theme svg').hasClass('fa-sun', 'it shows light icon');

    await click('#theme');

    assert.dom('#theme svg').hasClass('fa-moon', 'it shows dark icon');
    assert.strictEqual(
      localStorage.getItem('theme'),
      'dark',
      'it updates localStorage',
    );
  });

  test('it handles updates from different tabs', async function (assert) {
    localStorage.setItem('theme', 'light');

    const simulateStorageEvent = () => {
      const event = new StorageEvent('storage', {
        key: 'theme',
        newValue: 'dark',
      });
      dispatchEvent(event);
    };

    await render(<template><ThemeButton /></template>);

    assert.dom('#theme svg').hasClass('fa-sun', 'it shows light icon');

    simulateStorageEvent();
    await rerender();

    assert.dom('#theme svg').hasClass('fa-moon', 'it shows dark icon');
  });
});
