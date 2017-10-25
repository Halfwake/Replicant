package Replicant;

use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

use Replicant::Predicate;
use Replicant::Network;

our $VERSION = '0.0.0';

sub version { $VERSION; }

sub rule_to_full_url ($url, $rule) {
    $rule =~ s/^\s+//;
    $url . $rule;
}

sub filter_fetch_rules ($url) {
    my @lines = fetch_robot_rules($url);
    @lines = grep(&is_absolute_rule, @lines) if ($must_be_absolute);
    @lines = grep(&is_relative_rule, @lines) if ($must_be_relative);
    @lines = grep(&is_allow_rule, @lines) if ($must_be_allow);
    @lines = grep(&is_disallow_rule, @lines) if ($must_be_disallow);
    @lines;
}

1;
