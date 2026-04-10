const STORAGE_KEY = 'keycloak-theme-preference';
const THEME_DARK = 'dark';
const THEME_LIGHT = 'light';

const getSystemTheme = () =>
  window.matchMedia('(prefers-color-scheme: dark)').matches ? THEME_DARK : THEME_LIGHT;

const getStoredTheme = () => {
  try {
    return localStorage.getItem(STORAGE_KEY);
  } catch {
    return null;
  }
};

const storeTheme = (theme) => {
  try {
    localStorage.setItem(STORAGE_KEY, theme);
  } catch {
    // localStorage not available
  }
};

const getEffectiveTheme = () => getStoredTheme() ?? getSystemTheme();

const updateToggleIcon = (theme) => {
  const toggles = document.querySelectorAll('#theme-toggle, #theme-toggle-mobile');

  for (const toggle of toggles) {
    const icon = toggle.querySelector('i');
    if (!icon) continue;

    const isDark = theme === THEME_DARK;
    icon.classList.toggle('fa-moon', !isDark);
    icon.classList.toggle('fa-sun', isDark);
    toggle.setAttribute('aria-label', `Switch to ${isDark ? 'light' : 'dark'} mode`);
  }
};

const setTheme = (theme) => {
  document.documentElement.setAttribute('data-theme', theme);
  updateToggleIcon(theme);
};

const toggleTheme = () => {
  const current = document.documentElement.getAttribute('data-theme') || getEffectiveTheme();
  const newTheme = current === THEME_DARK ? THEME_LIGHT : THEME_DARK;
  setTheme(newTheme);
  storeTheme(newTheme);
};

const initTheme = () => {
  setTheme(getEffectiveTheme());

  const toggles = document.querySelectorAll('#theme-toggle, #theme-toggle-mobile');
  for (const toggle of toggles) {
    toggle.addEventListener('click', toggleTheme);
  }

  window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', (e) => {
    if (!getStoredTheme()) {
      setTheme(e.matches ? THEME_DARK : THEME_LIGHT);
    }
  });
};

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initTheme);
} else {
  initTheme();
}

export { toggleTheme, setTheme, getEffectiveTheme };
