import { module, test } from 'qunit';
import { setupTest } from 'charlesfries/tests/helpers';
import type IndexController from 'charlesfries/controllers/index';

module('Unit | Controller | index', function (hooks) {
  setupTest(hooks);

  test('it exists', function (assert) {
    const controller = this.owner.lookup('controller:index') as IndexController;
    assert.ok(controller);

    assert.strictEqual(controller.sort, 'pushed');
    assert.strictEqual(controller.direction, 'desc');
  });
});
