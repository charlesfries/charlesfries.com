import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { render, rerender } from '@ember/test-helpers';
import Pagination from 'charlesfries/components/pagination';
import { tracked } from '@glimmer/tracking';

module('Integration | Component | pagination', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    class State {
      @tracked meta = {
        hasMore: false,
        first: null,
        last: null,
        remainingRequests: null,
        maxRequests: null,
        resetAt: null,
      };
      @tracked isBackward: boolean | null = null;
    }
    const state = new State();

    await render(
      <template>
        <Pagination @meta={{state.meta}} @isBackward={{state.isBackward}} />
      </template>,
    );

    const previousBtn = assert.dom('[aria-label="Previous"]');
    const nextBtn = assert.dom('[aria-label="Next"]');

    previousBtn.hasText('Previous');
    nextBtn.hasText('Next');

    previousBtn.hasAria('disabled');
    nextBtn.hasAria('disabled');

    assert
      .dom('[aria-label="Previous"] svg')
      .exists('it shows a previous icon');
    assert.dom('[aria-label="Next"] svg').exists('it shows a next icon');

    state.meta = {
      ...state.meta,
      hasMore: true,
    };
    await rerender();

    previousBtn.hasAria('disabled');
    nextBtn.doesNotHaveAria('disabled');

    state.isBackward = false;
    await rerender();

    previousBtn.doesNotHaveAria('disabled');
    nextBtn.doesNotHaveAria('disabled');

    state.meta = {
      ...state.meta,
      hasMore: false,
    };
    await rerender();

    previousBtn.doesNotHaveAria('disabled');
    nextBtn.hasAria('disabled');

    state.meta = {
      ...state.meta,
      hasMore: true,
    };
    state.isBackward = true;
    await rerender();

    previousBtn.doesNotHaveAria('disabled');
    nextBtn.doesNotHaveAria('disabled');

    state.meta = {
      ...state.meta,
      hasMore: false,
    };
    await rerender();

    previousBtn.hasAria('disabled');
    nextBtn.doesNotHaveAria('disabled');
  });
});
