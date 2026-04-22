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
    assert.dom('header #locale-select').exists();
    assert.dom('header #theme-button').exists();
    assert.dom('header #description').exists();
    assert.dom('header #socials').exists();
    assert.dom('header #nav').exists();

    assert.dom('main #technologies').exists();
    assert.dom('main #toolbar').exists();
    assert.dom('main #error-alert').exists(); // TODO: enable netlify server in test

    assert.dom('footer').exists();
  });
});
