package Replicant::Predicate;

use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

our @EXPORT = qw(is_disallow_rule is_allow_rule is_absolute_rule is_relative_rule);

sub is_disallow_rule ($line) {
    $line =~ /^Disallow:/;
}

sub is_allow_rule ($line) {
    $line =~ /^Allow:/;
}

sub is_absolute_rule ($line) {
    $line =~ '/\*/';
}

sub is_relative_rule ($line) {
    !is_absolute_link($line); # Too bad we don't have function composition.
}

1;

__END__

=pod

=head1 NAME

Replicant::Predicate - functions for filtering robot rules

=head1 SYNOPSIS

  ## Rules that refer to a specific link.
  my @absolute_rules = grep(&is_absolute_rule, @rules);

  ## Rules that refer to a link you are discouraged from visiting.
  my @disallow_rules = grep(&is_disallow_rule, @rules);

=head1 DESCRIPTION

These are the functions Replicant uses to filter rules. They are not intended to be used directly for most people. I've made them accessible and documented them because, they may be useful. For instance, a user might want to count how many rules there are of a certain kind or check if a certain kind of rule exists.

=head1 FUNCTIONS

=head2 is_disallow_rule

  print "Not supposed to fetch this!\n" if is_disallow_rule($rule);

Check if the string is a disallow rule.

=head2 is_allow_rule

  print "You can fetch this!\n" if is_allow_rule($rule);

Check if the given string is an allow rule.

=head2 is_absolute_rule

  print "This rule isn't a pattern." if is_absolute_rule($rule);

Check if a given string refers to one specific link.

=head2 is_relative_rule

  print "This rule is a pattern." if is_relative_rule($rule);

Check if a given string refers to a pattern of links.

=head1 CAVEAT

These rules assume the given string is a valid rule line in a 'robots.txt' file. If you enter in whitespace or some kind of 'robots.txt.' comment, then the behavior is undefined. But why would you do that anyway?

=cut
