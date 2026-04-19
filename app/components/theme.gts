import { on } from '@ember/modifier';
import { service } from '@ember/service';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import { faMoon, faSun } from '@fortawesome/free-solid-svg-icons';
import Component from '@glimmer/component';
import ThemeService from 'charlesfries/services/theme';
import { BUTTON } from 'charlesfries/utils/class-names';
import { t } from 'ember-intl';

export default class Theme extends Component {
  @service declare theme: ThemeService;

  <template>
    <button
      type="button"
      class="{{BUTTON.secondary}} rounded-lg cursor-pointer"
      aria-label={{t "toggleTheme"}}
      {{on "click" this.theme.toggle}}
    >
      <FaIcon @icon={{if this.theme.isDark faMoon faSun}} />
    </button>
  </template>
}
