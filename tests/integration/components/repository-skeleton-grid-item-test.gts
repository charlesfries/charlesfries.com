import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { render } from '@ember/test-helpers';
import RepositorySkeletonGridItem from 'charlesfries/components/repository-skeleton-grid-item';

module(
  'Integration | Component | repository-placeholder-grid-item',
  function (hooks) {
    setupRenderingTest(hooks);

    test('it renders', async function (assert) {
      await render(<template><RepositorySkeletonGridItem /></template>);

      assert.dom('#repository-skeleton-grid-item').exists();
    });
  },
);
