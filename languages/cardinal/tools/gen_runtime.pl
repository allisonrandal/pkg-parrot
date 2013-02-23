#! perl
use strict;
use warnings;
use lib qw(lib);

my $runtime_dir = 'runtime/parts';

print <<EOH;
# This file automatically generated by $0.

EOH

my @runtime_cmds = pir_cmds_in_dir($runtime_dir);

print ".HLL 'Ruby', 'ruby_group'\n";

print "  .include 'languages/cardinal/$runtime_dir/$_.pir'\n" for @runtime_cmds;

sub pir_cmds_in_dir {
    my ($dir) = @_;

    opendir( DIR, $dir );

    # only return pir files (and strip the extension)
    my @files = grep { s/\.pir$// } readdir(DIR);
    closedir(DIR);

    return @files;
}

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4: