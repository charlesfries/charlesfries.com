import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { click, render } from '@ember/test-helpers';
import ThemeButton from 'charlesfries/components/theme-button';
import Service from '@ember/service';

module('Integration | Component | theme-button', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template><ThemeButton /></template>);

    assert
      .dom('#theme-button')
      .hasAria('label', 'Toggle theme', 'it has correct aria-label');
  });

  test('it shows light state', async function (assert) {
    class MockTheme extends Service {
      isDark = false;
      toggle() {}
    }

    this.owner.register('service:theme', MockTheme);

    await render(<template><ThemeButton /></template>);

    assert.dom('#theme-button svg').hasClass('fa-sun', 'it shows light icon');
  });

  test('it shows dark state', async function (assert) {
    class MockTheme extends Service {
      isDark = true;
      toggle() {}
    }

    this.owner.register('service:theme', MockTheme);

    await render(<template><ThemeButton /></template>);

    assert.dom('#theme-button svg').hasClass('fa-moon', 'it shows dark icon');
  });

  test('it calls toggle from theme service', async function (assert) {
    class MockTheme extends Service {
      isDark = false;
      toggle() {
        assert.ok(true, 'it calls toggle');
      }
    }

    this.owner.register('service:theme', MockTheme);

    await render(<template><ThemeButton /></template>);

    await click('#theme-button');
  });
});
