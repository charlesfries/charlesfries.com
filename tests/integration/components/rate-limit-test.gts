import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { render, rerender } from '@ember/test-helpers';
import RateLimit from 'charlesfries/components/rate-limit';
import { tracked } from '@glimmer/tracking';

module('Integration | Component | rate-limit', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    class State {
      @tracked remaining: number | null = 5;
      @tracked max: number | null = 10;
      @tracked resetAt: string | null = '1776582000';
    }
    const state = new State();

    await render(
      <template>
        <RateLimit
          @remaining={{state.remaining}}
          @max={{state.max}}
          @resetAt={{state.resetAt}}
        />
      </template>,
    );

    assert
      .dom()
      .hasText(
        '5 of 10 requests remaining (resets at 12:00 AM)',
        'it shows the correct text',
      );

    state.remaining = 1;
    await rerender();

    assert
      .dom('#rate-limit')
      .hasClass(
        'text-red-500',
        'it changes color when remaining requests are low',
      );

    state.remaining = null;
    state.max = null;
    state.resetAt = null;
    await rerender();

    assert.dom().hasText('', 'it shows no text when remaining is null');
  });
});
