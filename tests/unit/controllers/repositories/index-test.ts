import { module, test } from 'qunit';
import { setupTest } from 'charlesfries/tests/helpers';
import type RepositoriesIndexController from 'charlesfries/controllers/repositories/index';

module('Unit | Controller | repositories/index', function (hooks) {
  setupTest(hooks);

  test('it exists', function (assert) {
    const controller = this.owner.lookup(
      'controller:repositories/index',
    ) as RepositoriesIndexController;
    assert.ok(controller);

    assert.true(controller.queryParams.includes('type'));
  });
});
