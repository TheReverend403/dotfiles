//
// Overrides
//

// Disable global menu on Alt
user_pref("ui.key.menuAccessKey", 0);

// Disable clipboard annoyances
user_pref("middlemouse.contentLoadURL", false);
user_pref("clipboard.autocopy", false);

// Don't ever start with Windows.
user_pref("toolkit.winRegisterApplicationRestart", false);

// ???
user_pref("browser.formfill.enable", false);

// Use system native emoji
user_pref("font.name-list.emoji", "emoji");

// Disable this annoying thing which I never actually use but constantly trigger.
user_pref("browser.tabs.allowTabDetach", false);

user_pref("extensions.pocket.enabled", false);

// Custom theming options
user_pref("userChrome.theme.proton_color.dark_blue_accent", false);
user_pref("userContent.page.proton_color.system_accent", true);
user_pref("widget.non-native-theme.use-theme-accent", true);

user_pref("media.ffmpeg.vaapi.enabled", true);

// https://bugzilla.mozilla.org/show_bug.cgi?id=1835182
// https://bugzilla.mozilla.org/show_bug.cgi?id=1835158
user_pref("browser.vpn_promo.enabled", false);

user_pref("browser.tabs.cardPreview.enabled", false);

user_pref("browser.urlbar.suggest.trending", false);
