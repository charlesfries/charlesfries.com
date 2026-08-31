import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { render } from '@ember/test-helpers';
import Socials from 'charlesfries/components/socials';

module('Integration | Component | socials', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template><Socials /></template>);

    assert.dom('#socials a').exists({ count: 6 }, 'it shows links');

    const links: Array<[string, string]> = [
      ['https://github.com/charlesfries', 'GitHub'],
      ['https://www.linkedin.com/in/charlesfries', 'LinkedIn'],
      ['https://twitter.com/charlesfries', 'X'],
      ['https://bsky.app/profile/charlesfries.com', 'Bluesky'],
      ['https://www.instagram.com/charlesfries', 'Instagram'],
      ['mailto:me@me@charlesfries.com', 'Email'],
    ];

    links.forEach(([href, label], index) => {
      assert
        .dom(`#socials a:nth-child(${index + 1})`)
        .hasAttribute('href', href, `it links to ${label}`);
      assert
        .dom(`#socials a:nth-child(${index + 1})`)
        .hasAttribute('aria-label', label, `it labels the ${label} link`);
    });
  });
});
