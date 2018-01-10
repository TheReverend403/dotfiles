// Hardware acceleration
user_pref('layers.acceleration.force-enabled', true);
user_pref('layers.offmainthreadcomposition.enabled', true);

// Disable global menu on Alt
user_pref('ui.key.menuAccessKey', 0);

// Disable safebrowsing
user_pref('browser.safebrowsing.enabled', false);
user_pref('browser.safebrowsing.malware.enabled', false);
user_pref('browser.safebrowsing.downloads.remote.enabled', false);

// Disable hello
user_pref('loop.enabled', false);

// Disable pocket
user_pref('browser.pocket.enabled', false);
user_pref('extensions.pocket.enabled', false);

// Disable sending of the health report
user_pref('datareporting.healthreport.uploadEnabled', false);
user_pref('datareporting.healthreport.service.enabled', false);
user_pref('datareporting.policy.dataSubmissionEnabled', false);

// Disable search suggestions
user_pref('browser.search.suggest.enabled', false);

// Disable formfill
user_pref('browser.formfill.enable', false);

// Disable restore session from crash
user_pref('browser.sessionstore.resume_from_crash', false);

// Don't let sites access the battery API
user_pref('dom.battery.enabled', false);

// Disable reader mode
user_pref('reader.parse-on-load.enabled', false);

// Clicking the URL bar selects all text
user_pref('browser.urlbar.clickSelectsAll', true);

// Disable clipboard annoyances
user_pref('middlemouse.contentLoadURL', false);
user_pref('clipboard.autocopy', false);

// Disable various info leaks
user_pref('beacon.enabled', false);
user_pref('device.sensors.enabled', false);
user_pref('browser.send_pings', false);

user_pref('accessibility.force_disabled', 1);

// Disable the UITour backend so there is no chance that a remote page can load in the background
user_pref('browser.uitour.enabled', false);

// https://wiki.mozilla.org/Platform/Features/Telemetry
// https://www.mozilla.org/en-US/legal/privacy/firefox.html#telemetry
// https://wiki.mozilla.org/Security/Reviews/Firefox6/ReviewNotes/telemetry
user_pref('toolkit.telemetry.enabled', false);

// Disable 'enhanced' new page
user_pref('browser.newtabpage.enhanced', false);
user_pref('browser.newtab.preload', false);
user_pref('browser.newtabpage.directory.ping', '');
user_pref('browser.newtabpage.directory.source', 'data:text/plain,{}');

// Disable Social Service API
user_pref('social.directories', '');
user_pref('social.shareDirectory', '');
user_pref('social.whitelist', '');
user_pref('social.remote-install.enabled', false);
user_pref('social.share.activationPanelEnabled', false);
user_pref('social.toast-notifications.enabled', false);

// Disable preloading of autocomplete URLs
user_pref('browser.urlbar.speculativeConnect.enabled', false);

// https://www.reddit.com/r/firefox/comments/7ait0j/fixworkaround_for_lag_and_high_cpuram_usage_on/
user_pref('browser.pagethumbnails.capturing_disabled', true);

// JSONView replacement
user_pref('devtools.jsonview.enabled', true);
