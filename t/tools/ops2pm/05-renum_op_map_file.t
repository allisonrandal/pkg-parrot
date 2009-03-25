#! perl
# Copyright (C) 2007-2008, Parrot Foundation.
# $Id: 05-renum_op_map_file.t 37532 2009-03-17 21:03:54Z allison $
# 05-renum_op_map_file.t

use strict;
use warnings;

use Test::More qw(no_plan); # tests => 14;
use Carp;
use Cwd;
use File::Basename;
use File::Copy;
use File::Path qw( mkpath );
use File::Spec;
use File::Temp qw( tempdir );
use Tie::File;
use lib 'lib';
use Parrot::OpsRenumber;

my ($self, @opsfiles);
my ($lastcode, $lastnumber);
my $numoutput = q{src/ops/ops.num};
my $cwd = cwd();
my $samplesdir = File::Spec->catdir( $cwd,
    ( qw| t tools ops2pm samples | )
);;
ok(-d $samplesdir, "Able to locate samples directory");

{
    ##### Prepare temporary directory for testing #####

    my $tdir = tempdir( CLEANUP => 1 );
    chdir $tdir or croak "Unable to change to testing directory: $!";
    my $opsdir = File::Spec->catdir ( $tdir, 'src', 'ops' );
    mkpath( $opsdir, 0, 755 ) or croak "Unable to make testing directory";

    ##### Test pre-Parrot 1.0 case
    my $major_version = 0;

    ##### Stage 1:  Generate ops.num de novo #####

    my @stage1 = qw(
        core_ops.original
        bit_ops.original
        ops_num.original
    );
    copy_into_position($samplesdir, \@stage1, q{original}, $opsdir);
    foreach my $f ( qw| core bit | ) {
        copy qq{$samplesdir/${f}_ops.original}, qq{src/ops/$f.ops.post}
            or croak "Unable to store $f for later testing: $!";
    }
    ($lastcode, $lastnumber) = run_test_stage(
        [ qw(
            src/ops/core.ops
            src/ops/bit.ops
        ) ],
        $numoutput,
        $major_version,
    );
    is($lastcode, q{bxors_s_s_sc},
        "Stage 1:  Got expected last opcode");
    is($lastnumber, 177,
        "Stage 1:  Got expected last opcode number");

    ###### Stage 2:  Delete some opcodes and regenerate ops.num #####

    my @stage2 = qw( bit_ops.second );
    copy_into_position($samplesdir, \@stage2, q{second}, $opsdir);
    ($lastcode, $lastnumber) = run_test_stage(
        [ qw(
            src/ops/core.ops
            src/ops/bit.ops
        ) ],
        $numoutput,
        $major_version,
    );

    is($lastcode, q{bxor_i_i_ic},
        "Stage 2:  Got expected last opcode");
    is($lastnumber, 172,
        "Stage 2:  Got expected last opcode number");

    ##### Stage 3:  Add some opcodes and regenerate ops.num #####

  TODO: {
        local $TODO = 'Post 1.0 regeneration problematic, TT #469';
    my @stage3 = qw( pic_ops.original );
    copy_into_position($samplesdir, \@stage3, q{original}, $opsdir);
    ($lastcode, $lastnumber) = run_test_stage(
        [ qw(
            src/ops/core.ops
            src/ops/bit.ops
            src/ops/pic.ops
        ) ],
        $numoutput,
        $major_version,
    );
    ($lastcode, $lastnumber) = get_last_opcode($numoutput);
    is($lastcode, q{pic_callr___pc},
        "Stage 3:  Got expected last opcode");
    is($lastnumber, 189,
        "Stage 3:  Got expected last opcode number");
  }

    ##### Stage 4:  Again generate ops.num de novo #####

    my @stage4 = qw(
        core_ops.original
        bit_ops.original
        ops_num.original
    );
    copy_into_position($samplesdir, \@stage4, q{original}, $opsdir);
    foreach my $f ( qw| core bit | ) {
        copy qq{$samplesdir/${f}_ops.original}, qq{src/ops/$f.ops.post}
            or croak "Unable to store $f for later testing: $!";
    }
    ($lastcode, $lastnumber) = run_test_stage(
        [ qw(
            src/ops/core.ops
            src/ops/bit.ops
        ) ],
        $numoutput,
        $major_version,
    );
    is($lastcode, q{bxors_s_s_sc},
        "Stage 1:  Got expected last opcode");
    is($lastnumber, 177,
        "Stage 1:  Got expected last opcode number");

    ##### Test post-Parrot 1.0 case
    $major_version = 1;

    ###### Stage 5:  Delete some opcodes and regenerate ops.num #####

  TODO: {
        local $TODO = 'Post 1.0 regeneration should work just like pre-1.0 regeneration, TT #469';
    my @stage5 = qw( bit_ops.second );
    copy_into_position($samplesdir, \@stage5, q{second}, $opsdir);
    ($lastcode, $lastnumber) = run_test_stage(
        [ qw(
            src/ops/core.ops
            src/ops/bit.ops
        ) ],
        $numoutput,
        $major_version,
    );
    is($lastcode, q{bxor_i_ic_ic},
        "Stage 2:  Got expected last opcode");
    is($lastnumber, 189,
        "Stage 2:  Got expected last opcode number");

    ##### Stage 6:  Add some opcodes and regenerate ops.num #####

    my @stage6 = qw( pic_ops.original );
    copy_into_position($samplesdir, \@stage6, q{original}, $opsdir);
    ($lastcode, $lastnumber) = run_test_stage(
        [ qw(
            src/ops/core.ops
            src/ops/bit.ops
            src/ops/pic.ops
        ) ],
        $numoutput,
        $major_version,
    );
    ($lastcode, $lastnumber) = get_last_opcode($numoutput);
    is($lastcode, q{pic_callr___pc},
        "Stage 6:  Got expected last opcode:  additions permitted");
    is($lastnumber, 194,
        "Stage 6:  Got expected last opcode number:  additions permitted");
  }

    # Go back where we started to activate cleanup
    chdir $cwd or croak "Unable to change back to starting directory: $!";
}

pass("Completed all tests in $0");

#################### SUBROUTINES ####################

sub run_test_stage {
    my ($opsfilesref, $numoutput, $major_version) = @_;
    my $self = Parrot::OpsRenumber->new(
        {
            argv    => $opsfilesref,
            moddir  => "lib/Parrot/OpLib",
            module  => "core.pm",
            inc_dir => "include/parrot/oplib",
            inc_f   => "ops.h",
            script  => $0,
        }
    );

    $self->prepare_ops();
    $self->renum_op_map_file($major_version);
    my ($lastcode, $lastnumber) = get_last_opcode($numoutput);
    return ($lastcode, $lastnumber);
}

sub copy_into_position {
    my ($samplesdir, $stageref, $ext, $opsdir) = @_;
    foreach my $or ( @{ $stageref } ) {
        my $fullor = File::Spec->catfile( $samplesdir, $or );
        my $real;
        ($real = $or) =~ s/\.$ext$//;
        $real =~ s/_/\./g;
        my $fullreal = File::Spec->catfile( $opsdir, $real );
        copy $fullor, $fullreal or croak "Unable to copy $or";
    }
}

sub get_last_opcode {
    my $file = shift;
    croak "$file not found: $!" unless -f $file;
    my (@lines, $lastline);
    tie @lines, 'Tie::File', $file or croak "Unable to tie to $file: $!";
    $lastline = $lines[-1];
    untie @lines or croak "Unable to untie from $file: $!";
    my ($lastcode, $lastnumber) = split /\s+/, $lastline, 2;
    croak "Couldn't parse last line of $file: $!"
        unless (defined $lastcode and defined $lastnumber);
    return ($lastcode, $lastnumber);
}

