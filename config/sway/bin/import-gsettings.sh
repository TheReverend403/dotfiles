#!/bin/sh
set -eu

# https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland#setting-values-in-gsettings

config="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-4.0/settings.ini"
if [ ! -f "$config" ]; then exit 1; fi

gnome_schema="org.gnome.desktop.interface"
gtk_theme="$(grep 'gtk-theme-name' "$config" | sed 's/.*\s*=\s*//')"
icon_theme="$(grep 'gtk-icon-theme-name' "$config" | sed 's/.*\s*=\s*//')"
cursor_theme="$(grep 'gtk-cursor-theme-name' "$config" | sed 's/.*\s*=\s*//')"
cursor_size="$(grep 'gtk-cursor-theme-size' "$config" | sed 's/.*\s*=\s*//')"
font_name="$(grep 'gtk-font-name' "$config" | sed 's/.*\s*=\s*//')"

gsettings set "$gnome_schema" gtk-theme "$gtk_theme"
gsettings set "$gnome_schema" icon-theme "$icon_theme"
gsettings set "$gnome_schema" cursor-theme "$cursor_theme"
gsettings set "$gnome_schema" cursor-size "$cursor_size"
gsettings set "$gnome_schema" font-name "$font_name"
swaymsg -q "font pango:$font_name" || true

# Set xcursor to match for xwayland.
# Currently broken as per https://github.com/swaywm/sway/issues/6931
# Works when applying the linked pull request.
# https://github.com/swaywm/sway/pull/7064.patch
swaymsg -q "seat * xcursor_theme $cursor_theme $cursor_size" || true

# Also set the env vars for processes started by systemd eg. mako
export GTK_THEME="$gtk_theme"
export XCURSOR_THEME="$cursor_theme"
export XCURSOR_SIZE="$cursor_size"
dbus-update-activation-environment --systemd XCURSOR_THEME XCURSOR_SIZE GTK_THEME
systemctl --user import-environment XCURSOR_THEME XCURSOR_SIZE GTK_THEME

# Make flatpak GTK apps match the host.
command -v flatpak >/dev/null 2>&1 && flatpak override --user --env=GTK_THEME="$gtk_theme"
