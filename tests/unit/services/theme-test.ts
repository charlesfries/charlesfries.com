import { module, skip, test } from 'qunit';
import { setupTest } from 'charlesfries/tests/helpers';

module('Unit | Service | theme', function (hooks) {
  setupTest(hooks);

  test('it exists', function (assert) {
    const service = this.owner.lookup('service:theme');
    assert.ok(service);
  });

  test('it uses localStorage light value', function (assert) {
    localStorage.setItem('theme', 'light');

    const service = this.owner.lookup('service:theme');

    assert.false(service.isDark, 'it is light');
  });

  test('it uses localStorage dark value', function (assert) {
    localStorage.setItem('theme', 'dark');

    const service = this.owner.lookup('service:theme');

    assert.true(service.isDark, 'it is dark');
  });

  test('it updates localStorage', function (assert) {
    localStorage.setItem('theme', 'light');

    const service = this.owner.lookup('service:theme');

    service.toggle();

    const themeValue = localStorage.getItem('theme');
    assert.strictEqual(themeValue, 'dark', 'it updates localStorage');
  });

  test('it defaults to browser theme', function (assert) {
    localStorage.removeItem('theme');

    interface Obj {
      matches: boolean;
    }

    interface MyMediaQueryList extends MediaQueryList {
      setMatches: (value: boolean) => void;
    }

    const state = new Map<string, Obj>();

    window.matchMedia = (query) => {
      if (!state.has(query)) {
        state.set(query, {
          matches: false,
        });
      }

      const entry = state.get(query)!;

      return {
        media: query,

        get matches() {
          return entry.matches;
        },

        setMatches(value: boolean) {
          entry.matches = value;
        },

        onchange: null,
        addListener() {},
        removeListener() {},
        addEventListener() {},
        removeEventListener() {},
        dispatchEvent() {
          return false;
        },
      };
    };

    const simulateBrowserDarkTheme = (isDark: boolean) => {
      const mediaQuery = matchMedia(
        '(prefers-color-scheme: dark)',
      ) as MyMediaQueryList;
      mediaQuery.setMatches(isDark);
    };

    const service = this.owner.lookup('service:theme');

    simulateBrowserDarkTheme(false);

    assert.false(service.isDark, 'it uses light theme');

    simulateBrowserDarkTheme(true);

    assert.true(service.isDark, 'it uses dark theme');
  });

  skip('it handles browser theme updates', function () {
    // TODO:
  });

  test('it handles updates from concurrent app instances', function (assert) {
    localStorage.setItem('theme', 'light');

    const simulateStorageEvent = () => {
      const event = new StorageEvent('storage', {
        key: 'theme',
        newValue: 'dark',
      });
      dispatchEvent(event);
    };

    const service = this.owner.lookup('service:theme');

    assert.false(service.isDark, 'it is light');

    simulateStorageEvent();

    assert.true(service.isDark, 'it is dark');
  });
});
