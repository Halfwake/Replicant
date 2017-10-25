package Replicant::Network;

use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

use LWP::UserAgent;

our @EXPORT = qw(fetch_robot_lines);

sub fetch_robot_lines ($url) {
    my $user_agent = LWP::UserAgent->new;
    $user_agent->agent($user_agent_name);
    my $robots_txt = $user_agent->get($url . '/robots.txt')->content;
    split(/\n/, $robots_txt);
}

1;
