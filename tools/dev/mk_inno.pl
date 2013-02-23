#! perl -w
################################################################################
# Copyright: 2005-2006 The Perl Foundation.  All Rights Reserved.
# $Id: mk_inno.pl 11146 2006-01-13 13:58:13Z fperrad $
################################################################################

=head1 TITLE

tools/dev/mk_inno.pl - Create a script for Inno Setup

=head1 SYNOPSIS

    % perl tools/dev/mk_inno.pl [options]

=head1 DESCRIPTION

=head2 Options

=over 4

=item C<prefix>

The install prefix.

=item C<version>

The parrot version.

=item C<icudir>

The directory to locate ICU.

=back

=head1 SEE ALSO

http://www.jrsoftware.org/

=cut

################################################################################

use strict;

my %options = (
		version => 'x.y.z',
		prefix => '\usr\local\parrot',
		icudir => '',
);

foreach (@ARGV) {
    if (/^--([^=]+)=(.*)/) {
        $options{$1} = $2;
    }
}

$options{prefix} =~ s/\//\\/g;
$options{icudir} =~ s/\//\\/g;

my $icu_section = '';
if ($options{icudir}) {
	$icu_section = qq{
Source: "$options{icudir}\\license.html"; DestDir: "{app}\\icu"; Flags:
Source: "$options{icudir}\\bin\\icu*.dll"; DestDir: "{app}\\bin"; Flags:
};
}

open OUT, "> parrot.iss" or die "Can't open parrot.iss";

print OUT qq{
; generated by tools/dev/mk_setup.pl for the Inno Setup Script Compiler.

[Setup]
AppName=parrot
AppVerName=parrot $options{version}
AppPublisher=The Perl Foundation
AppPublisherURL=http://www.parrotcode.org/
AppSupportURL=http://www.parrotcode.org/
AppUpdatesURL=http://www.parrotcode.org/
DefaultDirName={pf}\\parrot-$options{version}
DefaultGroupName=parrot
AllowNoIcons=yes
LicenseFile=$options{prefix}\\share\\doc\\parrot\\LICENSES\\Artistic
OutputDir=.\\
OutputBaseFilename=setup-parrot-$options{version}
Compression=lzma
SolidCompression=yes
ChangesAssociations=yes

[Files]
Source: "$options{prefix}\\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs
${icu_section}

[Icons]
Name: "{group}\\{cm:UninstallProgram,parrot}"; Filename: "{uninstallexe}"
};

close OUT;

