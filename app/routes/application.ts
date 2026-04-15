import Route from '@ember/routing/route';
import type RouterService from '@ember/routing/router-service';
import { service } from '@ember/service';
import { setBuildURLConfig } from '@warp-drive/utilities/json-api';
import { type IntlService as Intl } from 'ember-intl';
import mixpanel from 'mixpanel-browser';
import translationsEnUs from 'virtual:ember-intl/translations/en-us';
import translationsEsEs from 'virtual:ember-intl/translations/es-es';
import translationsFrFr from 'virtual:ember-intl/translations/fr-fr';
import translationsItIt from 'virtual:ember-intl/translations/it-it';
import translationsZhCn from 'virtual:ember-intl/translations/zh-cn';

setBuildURLConfig({
  host: null,
  namespace: 'api/v1',
});

export default class ApplicationRoute extends Route {
  @service declare intl: Intl;
  @service declare router: RouterService;

  constructor(...args: never[]) {
    super(...args);

    this.intl.addTranslations('en-us', translationsEnUs);
    this.intl.addTranslations('es-es', translationsEsEs);
    this.intl.addTranslations('fr-fr', translationsFrFr);
    this.intl.addTranslations('it-it', translationsItIt);
    this.intl.addTranslations('zh-cn', translationsZhCn);

    this.intl.setLocale('en-us');

    this.router.on('routeDidChange', () => {
      const page = this.router.currentURL;
      const title = this.router.currentRouteName || 'unknown';
      mixpanel.track('Page Viewed', { page, title });
    });
  }
}
