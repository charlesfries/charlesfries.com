import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import { faTriangleExclamation } from '@fortawesome/free-solid-svg-icons';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { t } from 'ember-intl';

const not = (value: unknown) => !value;

export interface ErrorAlertSignature {
  Args: {
    error: Error;
    message: string;
  };
  Element: HTMLDivElement;
}

export default class ErrorAlert extends Component<ErrorAlertSignature> {
  @tracked isOpen = false;

  <template>
    <div
      class="flex gap-4 bg-red-500 text-white rounded-lg p-4"
      role="alert"
      ...attributes
    >
      <div class="pt-1">
        <FaIcon @icon={{faTriangleExclamation}} />
      </div>
      <div>
        <p>{{@message}}</p>
        <button
          type="button"
          class="text-sm font-semibold cursor-pointer mt-1"
          {{on "click" (fn (mut this.isOpen) (not this.isOpen))}}
        >
          {{if this.isOpen (t "errorAlert.hide") (t "errorAlert.show")}}
          {{t "errorAlert.details"}}
        </button>
        {{#if this.isOpen}}
          <p class="text-sm mt-1">{{@error.message}}</p>
        {{/if}}
      </div>
    </div>
  </template>
}
