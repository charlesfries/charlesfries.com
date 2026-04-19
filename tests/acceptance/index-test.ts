import { module, test } from 'qunit';
import { visit, currentURL } from '@ember/test-helpers';
import { setupApplicationTest } from 'charlesfries/tests/helpers';

module('Acceptance | index', function (hooks) {
  setupApplicationTest(hooks);

  test('visiting /index', async function (assert) {
    await visit('/');

    assert.strictEqual(currentURL(), '/');

    assert.dom('header #avatar').exists();
    assert.dom('header #heading').exists();
    assert.dom('header #locale').exists();
    assert.dom('header #theme').exists();

    assert.dom('main #description').exists();
    assert.dom('main #socials').exists();
    assert.dom('main #technologies').exists();
    assert.dom('main #toolbar').exists();
    assert.dom('main #rate-limit').exists();
    assert.dom('main #grid').exists();
    assert.dom('main #pagination').exists();

    assert.dom('footer').exists();
  });
});
