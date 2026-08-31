import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { render } from '@ember/test-helpers';
import Technologies from 'charlesfries/components/technologies';

module('Integration | Component | technologies', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template><Technologies /></template>);

    assert.dom('#technologies img').exists({ count: 55 }, 'it shows badges');

    assert
      .dom('#technologies img:first-child')
      .hasAttribute('alt', 'Ember.js', 'it labels the first badge');
    assert
      .dom('#technologies img:first-child')
      .hasAttribute(
        'src',
        'https://img.shields.io/badge/Ember.js-e04e39?style=flat-square&logo=emberdotjs&logoColor=white',
        'it builds the badge url with a light logo color by default',
      );

    assert
      .dom('#technologies img[alt="React"]')
      .hasAttribute(
        'src',
        'https://img.shields.io/badge/React-61dafb?style=flat-square&logo=react&logoColor=black',
        'it uses a dark logo color when isDark is set',
      );
  });
});
