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

    assert.strictEqual(
      localStorage.getItem('theme'),
      'dark',
      'it updates localStorage',
    );
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
