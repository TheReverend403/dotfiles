user_pref('browser.urlbar.clickSelectsAll', true);
user_pref('middlemouse.contentLoadURL', false);
user_pref('clipboard.autocopy', false);
user_pref('browser.sessionstore.resume_from_crash', false);

// Disable hello
user_pref('loop.enabled', false);
user_pref("loop.logDomains", false);

// Disable pocket
user_pref("browser.pocket.enabled", false);
user_pref("extensions.pocket.enabled", false);

// Disable "enhanced" new page
user_pref("browser.newtabpage.enhanced", false);
user_pref("browser.newtab.preload", false);
user_pref("browser.newtabpage.directory.ping", "");
user_pref("browser.newtabpage.directory.source", "data:text/plain,{}");

// Disable sending of the health report
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.healthreport.service.enabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);

// Disable heartbeat
user_pref("browser.selfsupport.url", "");

// WebIDE
user_pref("devtools.webide.enabled", false);
user_pref("devtools.webide.autoinstallADBHelper", false);
user_pref("devtools.webide.autoinstallFxdtAdapters", false);

// Disable remote debugging
user_pref("devtools.debugger.remote-enabled", false);
user_pref("devtools.chrome.enabled", false);
user_pref("devtools.debugger.force-local", true);

// https://wiki.mozilla.org/Platform/Features/Telemetry
// https://www.mozilla.org/en-US/legal/privacy/firefox.html#telemetry
// https://wiki.mozilla.org/Security/Reviews/Firefox6/ReviewNotes/telemetry
user_pref("toolkit.telemetry.enabled", false);
// https://gecko.readthedocs.org/en/latest/toolkit/components/telemetry/telemetry/preferences.html
user_pref("toolkit.telemetry.unified", false);
// https://wiki.mozilla.org/Telemetry/Experiments
user_pref("experiments.supported", false);
user_pref("experiments.enabled", false);

// Disable the UITour backend so there is no chance that a remote page
user_pref("browser.uitour.enabled", false);

// Resist fingerprinting via window.screen and CSS media queries and other techniques
user_pref("privacy.resistFingerprinting", true);
