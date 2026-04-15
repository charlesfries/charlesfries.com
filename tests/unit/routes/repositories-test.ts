import { module, test } from 'qunit';
import { setupTest } from 'charlesfries/tests/helpers';

module('Unit | Route | repositories', function (hooks) {
  setupTest(hooks);

  test('it exists', function (assert) {
    const route = this.owner.lookup('route:repositories');
    assert.ok(route);
  });
});
