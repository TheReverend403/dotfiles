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

user_pref('extensions.pocket.enabled', false);

// Theming
// https://github.com/black7375/Firefox-UI-Fix/blob/photon-style/user.js

// userchrome.css usercontent.css activate
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Proton Enabled #127
user_pref("browser.proton.enabled", true);

// Proton Tooltip
user_pref("browser.proton.places-tooltip.enabled", true);

// Fill SVG Color
user_pref("svg.context-properties.content.enabled", true);

// CSS Color Mix - 88 Above
user_pref("layout.css.color-mix.enabled", true);

// CSS Blur Filter - 88 Above
user_pref("layout.css.backdrop-filter.enabled", true);

// Restore Compact Mode - 89 Above
user_pref("browser.compactmode.show", true);

// about:home Search Bar - 89 Above
user_pref("browser.newtabpage.activity-stream.improvesearch.handoffToAwesomebar", false);

// Browser Theme Based Scheme - Will be activate 95 Above
// user_pref("layout.css.prefers-color-scheme.content-override", 3);
