import Service from '@ember/service';
import type Owner from '@ember/owner';
import { tracked } from '@glimmer/tracking';
import mixpanel from 'mixpanel-browser';

type _Theme = 'light' | 'dark';

const LOCAL_STORAGE_KEY = 'theme';

export default class Theme extends Service {
  private mediaQuery = matchMedia('(prefers-color-scheme: dark)');

  @tracked private userTheme = localStorage.getItem(
    LOCAL_STORAGE_KEY,
  ) as _Theme | null;

  constructor(owner: Owner) {
    super(owner);

    this.apply();

    this.mediaQuery.addEventListener('change', this.handleMediaChange);
    addEventListener('storage', this.handleStorageChange);
  }

  override willDestroy() {
    super.willDestroy();

    this.mediaQuery.removeEventListener('change', this.handleMediaChange);
    removeEventListener('storage', this.handleStorageChange);
  }

  private handleMediaChange = () => {
    if (!this.userTheme) {
      this.apply();
    }
  };

  private handleStorageChange = (event: StorageEvent) => {
    if (event.key === LOCAL_STORAGE_KEY) {
      this.userTheme = event.newValue as _Theme | null;
      this.apply();
    }
  };

  private get systemTheme() {
    return (this.mediaQuery.matches ? 'dark' : 'light') as _Theme;
  }

  get isDark() {
    if (this.userTheme) {
      return this.userTheme === 'dark';
    }
    return this.systemTheme === 'dark';
  }

  toggle = () => {
    this.userTheme = this.isDark ? 'light' : 'dark';
    localStorage.setItem(LOCAL_STORAGE_KEY, this.userTheme);

    this.apply();

    mixpanel.track('Theme Changed', { theme: this.userTheme });
  };

  private apply = () => {
    const root = document.documentElement;
    const isDark = this.isDark;

    if (isDark === root.classList.contains('dark')) {
      return;
    }

    root.classList.toggle('dark', isDark);
  };
}

// Don't remove this declaration: this is what enables TypeScript to resolve
// this service using `Owner.lookup('service:theme')`, as well
// as to check when you pass the service name as an argument to the decorator,
// like `@service('theme') declare altName: ThemeService;`.
declare module '@ember/service' {
  interface Registry {
    theme: Theme;
  }
}
