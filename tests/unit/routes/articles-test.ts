import { module, test } from 'qunit';
import { setupTest } from 'charlesfries/tests/helpers';

module('Unit | Route | articles', function (hooks) {
  setupTest(hooks);

  test('it exists', function (assert) {
    const route = this.owner.lookup('route:articles');
    assert.ok(route);
  });
});
