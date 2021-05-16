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
