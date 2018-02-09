#!/usr/bin/env perl -w
use strict;
use utf8;

sub greentext_cb {
	my ($data, $mod, $mod_data, $msg) = @_;
	
	if ($msg =~ /^>/) {
		$msg="\x033" . $msg;
	}

	return $msg;
}

weechat::register("greentext.pl", "dcat,kori", "1.0", "beerware", "greentext", "", "");
weechat::hook_modifier("input_text_for_buffer", "greentext_cb", "");