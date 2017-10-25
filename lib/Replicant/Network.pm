# This file is part of Replicant.
#
# Replicant is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Replicant is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Replicant.  If not, see <http://www.gnu.org/licenses/>.

package Replicant::Network;

use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

use LWP::UserAgent;

our @EXPORT = qw(fetch_robot_lines);

sub fetch_robot_lines ($url, $user_agent = 0) {
    unless ($user_agent) {
	my $user_agent = LWP::UserAgent->new;
	$user_agent->agent($user_agent_name);
    }
    my $robots_txt = $user_agent->get($url . '/robots.txt')->content;
    split(/\n/, $robots_txt);
}

1;

__END__

=pod

=head1 NAME

Replicant::Network - the network part of getting robot rules

=head1 SYNOPSIS

  ## Get the file 'http://localhost/robots.txt'
  @lines = fetch_robot_lines("http://localhost/");

  ## Get the file 'http://localhost/robots.txt' using the given LWP UserAgent.
  my $user_agent = LWP::UserAgent->new;
  @lines = fetch_robot_lines("http://localhost/", $user_agent);

=head1 DESCRIPTION

Functions in here are for retrieving a 'robots.txt' file for further processing.

=head1 FUNCTIONS

=head2 fetch_robot_lines

  @lines = fetch_robot_lines('http://localhost/', LWP::UserAgent->new);
  
This will return a list of the rule lines in a robots file. All empty lines will be removed. The first argument is the root of the website you want to retrieve the file from, not the URL of the 'robots.txt' file.

  fetch_robot_lines('http://localhost/')           #Correct!
  fetch_robot_lines('http://localhost/robots.txt') #Wrong!

The second argument is an optional LWP or LWP comptaible user agent object. If you provide one, it will be used to download the robot file. If you do not provide an argument, then a default user agent will be used.

=cut
