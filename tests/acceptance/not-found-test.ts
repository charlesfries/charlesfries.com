import { module, test } from 'qunit';
import { visit, currentURL, click } from '@ember/test-helpers';
import { setupApplicationTest } from 'charlesfries/tests/helpers';

module('Acceptance | not found', function (hooks) {
  setupApplicationTest(hooks);

  test('visiting /not-found', async function (assert) {
    await visit('/not-found');

    assert.strictEqual(currentURL(), '/not-found');

    assert.dom('header #avatar').exists();
    assert.dom('header #heading').exists();
    assert.dom('header #locale-select').exists();
    assert.dom('header #theme-button').exists();
    assert.dom('header #description').exists();
    assert.dom('header #socials').exists();
    assert.dom('header #nav').exists();

    assert.dom('main img').exists();
    assert.dom('main h2').exists();
    assert.dom('main p').exists();
    assert.dom('main a').exists();

    assert.dom('footer').exists();

    await click('main a');

    assert.strictEqual(currentURL(), '/');
  });
});
