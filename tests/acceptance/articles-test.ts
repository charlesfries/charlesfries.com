import { module, test } from 'qunit';
import { visit, currentURL } from '@ember/test-helpers';
import { setupApplicationTest } from 'charlesfries/tests/helpers';

module('Acceptance | articles', function (hooks) {
  setupApplicationTest(hooks);

  test('visiting /articles', async function (assert) {
    await visit('/articles');

    assert.strictEqual(currentURL(), '/articles');
  });
});
