import { BUTTON } from 'charlesfries/utils/class-names';
import { module, test } from 'qunit';

module('Unit | Utility | class-names', function () {
  test('it works', function (assert) {
    assert.strictEqual(typeof BUTTON.primary, 'string');
    assert.strictEqual(typeof BUTTON.secondary, 'string');
  });
});
