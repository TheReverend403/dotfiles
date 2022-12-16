#!/usr/bin/fish

function _notify
    command -q notify-send; and notify-send --app-name "wpste" $argv; or true
end

function _log
    set -l level $argv[1]
    set -l message $argv[2..]

    switch $level
        case INFO
            set level_color green
        case WARN
            set level_color yellow
        case ERROR
            set level_color red
        case DEBUG
            set level_color cyan
        case '*'
            log_error "Invalid log level "$level"" 1>&2
            return
    end

    begin
        printf "%s" "["
        isatty stderr; and set_color $level_color
        printf "%s" "$level"
        isatty stderr; and set_color normal
        printf "] %s\n" "$message"
    end 1>&2
end

function log_info
    _log "INFO" $argv
end

function log_warn
    _log "WARN" $argv
end

function log_error
    set -l options \
        (fish_opt --short e --long exit --required-val)

    argparse --stop-nonopt $options -- $argv
    or return

    _log "ERROR" $argv
    if set -q __notify_on_error
        _notify -u critical "wpste error:" "$argv"
    end

    if set -q _flag_e
        exit $_flag_e
    end
end

function log_debug
    set -q WPSTE_DEBUG; and _log "DEBUG" $argv 1>&2
end

function _print_help
    log_info "A simple grimshot wrapper for https://github.com/TheReverend403/pste with support for editing before upload."
    log_info "Usage: wpste [-t|--target <active|screen|output|area|window>] [-c|--copy] [-n|--notify] [-e|--edit] [file]"
    exit 0
end

function _is_image
    set -l file $argv[1]
    set -l mimetype (mimetype -b "$file")
    string match "image/*" "$mimetype"
end

function _check_requirements
    set -l required_commands curl mpv notify-send grimshot wl-copy swappy

    if not set -q WAYLAND_DISPLAY
        log_error --exit 1 "WAYLAND_DISPLAY is not set. wpste expects a Wayland environment."
    end

    for requirement in $required_commands
        if not command -q "$requirement"
            log_error --exit 1 "Missing requirement: $requirement"
        else
            log_debug "Found requirement: $requirement"
        end
    end
end

function _play_sound
    set -l sound_file "camera-shutter.oga"
    set -l sound_file "/usr/share/sounds/freedesktop/stereo/$sound_file"

    if test -f "$sound_file"
        mpv --no-video --no-terminal "$sound_file" &
    else
        log_warn "_play_sound: $sound_file not found."
    end
end

function _take_screenshot
    set -l target $argv[1]
    set -l save_path (mktemp --tmpdir --suffix=.png wpste_(date --iso-8601).XXXX)

    set -l grimshot_output (grimshot save "$target" "$save_path" 2>&1)
    set -l grimshot_status $status
    if not test $grimshot_status -eq 0
        if string match -q "selection cancelled" "$grimshot_output"
            # Capitalise the s, add a period.
            log_info (string replace -r "^s" "S" "$grimshot_output."); exit 0
        end
        log_error --exit $grimshot_status "Grimshot error: $grimshot_output"
    end

    _play_sound
    log_debug "Screenshot saved to $save_path"
    echo "$grimshot_output"
end

function _upload_file
    set -l options \
        (fish_opt --short k --long key --required-val) \
        (fish_opt --short f --long file --required-val)

    argparse $options -- $argv
    or return

    if not set -q _flag_k; and not set -q _flag_f
        log_error --exit 2 "_upload_file: Expected --key and --file."
    end

    if not test -f "$_flag_f"
        log_error --exit 1 "$_flag_f does not exist."
    end

    log_debug "Uploading $_flag_f"
    set -l response (curl -sSL -H "Authorization: Bearer $_flag_k" -F file="@$_flag_f" "$CONFIG_UPLOAD_URL" 2>&1)
    set -l curl_status $status

    test $curl_status -eq 0; or log_error --exit $curl_status "Upload failed: $response"
    echo "$response" | jq .url --raw-output; or log_error --exit $status "JSON parsing failed: $response"
end

function _copy_to_clipboard
    set -l options \
        (fish_opt --short f --long file --required-val) \
        (fish_opt --short t --long text --required-val)

    argparse $options -- $argv
    or return

    if not set -q _flag_f; and not set -q _flag_t
        log_error --exit 2 "_copy_to_clipboard: Expected at least one of --text or --file."
    end

    if set -q _flag_t
        wl-copy "$_flag_t"; or log_error --exit $status "Failed to copy $_flag_t to the clipboard."
    end

    if set -q _flag_f
        set -l mimetype (_is_image "$_flag_f")
        if test $status -eq 0
            log_debug "Copying $_flag_f to primary clipboard as $mimetype."
            cat "$_flag_f" | wl-copy --primary --type "$mimetype"; or log_error --exit $status "Failed to copy $_flag_f to the clipboard."
        else
            log_debug "$_flag_f is not an image. Not copying to clipboard."
        end
    end
end

function _source_config
    set -l config_file "$XDG_CONFIG_HOME/wpste/config"
    if not test -f "$config_file"
        set -l default_config \
            "## API key for your pste instance. Required." \
            "# API_KEY=" \
            "## URL to your pste instance's upload endpoint. Optional." \
            "# UPLOAD_URL=https://dev.pste.pw/api/upload"

        log_error "No config file found at $config_file. A default one will be created."
        mkdir -p "$(dirname "$config_file")"; or log_error --exit $status "Failed to create default config file."
        echo -e "$(string join '\n' $default_config)" > "$config_file"
        exit 1
    end

    for line in (cat "$config_file" | string match -rv "^#")
        set -l item (string match -r "^\w+=\w+" "$line" | string split -m 1 "="); or continue
        log_debug "_source_config: CONFIG_$item[1]=$item[2]"
        set -g CONFIG_$item[1] $item[2]
    end

    set -q CONFIG_UPLOAD_URL; or set -g CONFIG_UPLOAD_URL "https://dev.pste.pw/api/upload"
end

function wpste_main
    _check_requirements
    _source_config

    set -l options \
        (fish_opt --short h --long help) \
        (fish_opt --short c --long copy) \
        (fish_opt --short n --long notify) \
        (fish_opt --short e --long edit) \
        (fish_opt --short t --long target --required-val) \

    argparse --name=wpste --stop-nonopt $options -- $argv
    or return

    test (count $argv) -eq 1; and set -l _flag_f $argv[1]

    log_debug "_flag_h: $_flag_h"
    log_debug "_flag_c: $_flag_c"
    log_debug "_flag_n: $_flag_n"
    log_debug "_flag_t: $_flag_t"
    log_debug "_flag_f: $_flag_f"

    set -q _flag_h; and _print_help

    set -q _flag_n; and set -g __notify_on_error

    if set -q _flag_t
        set -l valid_targets "active" "screen" "output" "area" "window"
        if not contains "$_flag_t" $valid_targets
            set -l valid_targets (string join ", " $valid_targets)
            log_error --exit 2 -- "--target must be one of $valid_targets."
        end
    else
        set -l _flag_t "output"
    end

    if not set -q _flag_f
        set _flag_f (_take_screenshot "$_flag_t")
    end

    if set -q _flag_e
        if not _is_image "$_flag_f" > /dev/null
            log_warn "Ignoring --edit because $_flag_f is not an image."
        else
            swappy -f "$_flag_f" -o "$_flag_f"; or log_error --exit $status "Editing image failed."
        end
    end

    set -l url (_upload_file --file "$_flag_f" --key "$CONFIG_API_KEY")

    if set -q _flag_c
        _copy_to_clipboard --text "$url" --file "$_flag_f"
        if set -q _flag_n
            set -l notification_title "URL copied to clipboard."
            set -l notification_args
            if _is_image "$_flag_f" > /dev/null
                set -p notification_title "Image and"
                set notification_args --icon "$_flag_f"
            end
            _notify $notification_args "$notification_title" "$url"
        end
    end

    echo "$url"
end

wpste_main $argv
