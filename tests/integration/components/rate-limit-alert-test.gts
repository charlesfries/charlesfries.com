import { module, test } from 'qunit';
import { setupRenderingTest } from 'charlesfries/tests/helpers';
import { render, rerender } from '@ember/test-helpers';
import RateLimitAlert from 'charlesfries/components/rate-limit-alert';
import { tracked } from '@glimmer/tracking';

module('Integration | Component | rate-limit-alert', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    const resetAt = (
      new Date(Date.UTC(2026, 3, 19)).getTime() / 1000
    ).toString();

    class State {
      @tracked remaining: number | null = 5;
      @tracked max: number | null = 10;
      @tracked resetAt: string | null = resetAt;
    }
    const state = new State();

    await render(
      <template>
        <RateLimitAlert
          @remaining={{state.remaining}}
          @max={{state.max}}
          @resetAt={{state.resetAt}}
        />
      </template>,
    );

    assert.dom().includesText(
      '5 of 10 requests remaining (resets at ', // TODO: test time `5:00 PM)`
      'it shows the correct text',
    );
    assert
      .dom('#rate-limit-alert')
      .hasClass('text-neutral-500', 'it uses the default color initially');
    assert.dom('#rate-limit-alert svg').exists('it shows an info icon');

    state.remaining = 1;
    await rerender();

    assert
      .dom('#rate-limit-alert')
      .hasClass(
        'text-red-500',
        'it changes color when remaining requests are low',
      );

    state.remaining = 2;
    await rerender();

    assert
      .dom('#rate-limit-alert')
      .hasClass(
        'text-neutral-500',
        'it is no longer low just above the 10% boundary (max is 10, so 1 is the boundary)',
      );

    state.max = null;
    await rerender();

    assert
      .dom('#rate-limit-alert')
      .hasClass(
        'text-neutral-500',
        'it does not treat a null max as running low',
      );
    assert
      .dom()
      .includesText(
        'requests remaining',
        'it still shows text when only max is null',
      );

    state.remaining = null;
    state.max = null;
    state.resetAt = null;
    await rerender();

    assert.dom().hasText('', 'it shows no text when remaining is null');
  });
});
