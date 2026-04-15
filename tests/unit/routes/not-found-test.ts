import { module, test } from 'qunit';
import { setupTest } from 'charlesfries/tests/helpers';

module('Unit | Route | not-found', function (hooks) {
  setupTest(hooks);

  test('it exists', function (assert) {
    const route = this.owner.lookup('route:not-found');
    assert.ok(route);
  });
});
