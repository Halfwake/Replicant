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

package Replicant;

use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

use Replicant::Predicate;
use Replicant::Network;

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
