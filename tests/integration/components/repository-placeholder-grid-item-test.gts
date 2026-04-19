import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { render } from '@ember/test-helpers';
import RepositoryPlaceholderGridItem from 'charlesfries/components/repository-placeholder-grid-item';

module(
  'Integration | Component | repository-placeholder-grid-item',
  function (hooks) {
    setupRenderingTest(hooks);

    test('it renders', async function (assert) {
      await render(<template><RepositoryPlaceholderGridItem /></template>);

      assert.dom('div').exists();
    });
  },
);
