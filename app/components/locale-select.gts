import { service } from '@ember/service';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import { faAngleDown } from '@fortawesome/free-solid-svg-icons';
import Component from '@glimmer/component';
import { BUTTON } from 'charlesfries/utils/class-names';
import { t, type IntlService } from 'ember-intl';
import mixpanel from 'mixpanel-browser';

const locales = ['en-us', 'zh-cn', 'es-es', 'fr-fr', 'it-it'];

const options = locales.map((locale) => {
  const [lang = locale] = locale.split('-');

  let native = new Intl.DisplayNames([lang], { type: 'language' }).of(lang) ?? lang;
  native = native.charAt(0).toUpperCase() + native.slice(1);

  return { value: locale, label: native };
});

export default class LocaleSelect extends Component {
  @service declare intl: IntlService;

  setLocale = (event: Event) => {
    const { value } = event.target as HTMLSelectElement;

    this.intl.setLocale(value);

    mixpanel.track('Locale Changed', { locale: value });
  };

  <template>
    <div id="locale-select" class="relative">
      <select
        class="{{BUTTON.secondary}}
          rounded-lg appearance-none outline-none pr-8"
        name="locale"
        aria-label={{t "locale"}}
        {{on "change" this.setLocale}}
      >
        {{#each options as |opt|}}
          <option value={{opt.value}}>{{opt.label}}</option>
        {{/each}}
      </select>
      <div
        class="pointer-events-none absolute inset-y-0 right-3 flex items-center"
      >
        <FaIcon @icon={{faAngleDown}} />
      </div>
    </div>
  </template>
}
