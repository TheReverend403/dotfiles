// Disable global menu on Alt
user_pref('ui.key.menuAccessKey', 0);

// Disable clipboard annoyances
user_pref('middlemouse.contentLoadURL', false);
user_pref('clipboard.autocopy', false);

// Don't ever start with Windows.
user_pref('toolkit.winRegisterApplicationRestart', false);

// ???
user_pref('browser.formfill.enable', false);

// Use system native emoji
user_pref('font.name-list.emoji', 'emoji');

// Disable this annoying thing which I never actually use but constantly trigger.
user_pref('browser.tabs.allowTabDetach', false);

// Theming
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// https://github.com/black7375/Firefox-UI-Fix/blob/photon-style/user.js
user_pref("svg.context-properties.content.enabled", true);
user_pref("layout.css.backdrop-filter.enabled", true);
user_pref("browser.compactmode.show", true);
