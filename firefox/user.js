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

// Stop cache bloat.
user_pref('browser.cache.disk.smart_size.enabled', false);

// Better smooth scrolling
// https://old.reddit.com/r/firefox/comments/bvfqtp/these_are_the_smooth_scrolling_tweaks_i_play/
user_pref("general.smoothScroll.lines.durationMaxMS", 125);
user_pref("general.smoothScroll.lines.durationMinMS", 125);
user_pref("general.smoothScroll.mouseWheel.durationMaxMS", 200);
user_pref("general.smoothScroll.mouseWheel.durationMinMS", 100);
user_pref("general.smoothScroll.other.durationMaxMS", 125);
user_pref("general.smoothScroll.other.durationMinMS", 125);
user_pref("general.smoothScroll.pages.durationMaxMS", 125);
user_pref("general.smoothScroll.pages.durationMinMS", 125);
user_pref("mousewheel.system_scroll_override_on_root_content.horizontal.factor", 175);
user_pref("mousewheel.system_scroll_override_on_root_content.vertical.factor", 175);
user_pref("toolkit.scrollbox.horizontalScrollDistance", 6);
user_pref("toolkit.scrollbox.verticalScrollDistance", 2);
user_pref("apz.frame_delay.enabled", false);
user_pref("general.smoothScroll.msdPhysics.enabled", true);

// Theming
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// https://github.com/black7375/Firefox-UI-Fix/blob/photon-style/user.js
user_pref("svg.context-properties.content.enabled", true);
user_pref("layout.css.backdrop-filter.enabled", true);
user_pref("browser.compactmode.show", true);
