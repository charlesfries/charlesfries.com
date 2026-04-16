import { module, test } from 'qunit';
import { setupTest } from 'charlesfries/tests/helpers';
import type RepositoriesController from 'charlesfries/controllers/repositories';

module('Unit | Controller | repositories', function (hooks) {
  setupTest(hooks);

  test('it exists', function (assert) {
    const controller = this.owner.lookup(
      'controller:repositories',
    ) as RepositoriesController;
    assert.ok(controller);

    assert.strictEqual(controller.sort, 'pushed');
    assert.strictEqual(controller.direction, 'desc');
  });
});
