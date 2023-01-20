
//
// Overrides
//

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

// Custom theming options
user_pref("userChrome.theme.proton_color.dark_blue_accent", true);

user_pref("media.ffmpeg.vaapi.enabled", true);

// Disable the extension button that for some reason can't be removed via the UI.
// Fuck you Mozilla.
user_pref("extensions.unifiedExtensions.enabled", false);
