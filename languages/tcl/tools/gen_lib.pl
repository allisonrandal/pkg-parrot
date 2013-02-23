#! perl -w

use strict;
use lib qw(lib);

my $template = shift;

my $header = <<EOH;
# This file automatically generated by $0. Edit
# $template instead.

EOH

open(TEMPLATE,$template) or die;
local $/ = undef;
my $contents = $header . <TEMPLATE>;
close(TEMPLATE);

my $command_dir = "lib/commands";
opendir(CMDDIR,$command_dir);
my @cmd_files = readdir(CMDDIR);
closedir(CMDDIR);

my $builtins_dir = "lib/builtins";
opendir(CMDDIR,$builtins_dir);
my @blt_files = readdir(CMDDIR);
closedir(CMDDIR);

my $macro_dir = "lib/macros";
opendir(CMDDIR,$macro_dir);
my @macro_files = readdir(CMDDIR);
closedir(CMDDIR);

my @cmd_includes = map {"$command_dir/$_"} grep {m/\.pir$/}  @cmd_files;
my @blt_includes = map {"$builtins_dir/$_"} grep {m/\.pir$/} @blt_files;
my @macro_includes = map {"$macro_dir/$_"} grep {m/\.pir$/}  @macro_files;

# remove extensions from @cmd_files and @blt_files
# (this uses $_ as an alias -- somewhat subtle and evil)
my @commands = grep {s/\.(pir|tmt)$//} @cmd_files, @blt_files;

my $lib_dir = "lib";
opendir(LIBDIR,$lib_dir) or die;
my @libs = map {"$lib_dir/$_"} grep {m/\.pir$/} grep {! m/^tcl(lib|command|commandlist|const|func|ops|binaryops|var|word).pir$/} readdir(LIBDIR);
closedir(LIBDIR);

my $includes;
foreach my $file (@macro_includes, @cmd_includes, @blt_includes, @libs) {
  $includes .= "  .include \"languages/tcl/$file\"\n";
}

=head1 rules

Generate the PIR code that matches the various rules we have. (This code
is ignored for now.)

=cut

my $rulefile = "lib/tcl.p6r";
my $rules;

=for later

open (RULES,$rulefile) or die "can't read rules file.\n";

$rules = <<'EOH';
# Read in any of the perl6-ian grammars that have been defined for Tcl

.sub "_load_grammar"
  .local pmc p6rule_compile
  p6rule_compile = find_global "PGE", "p6rule"

  .local string grammar
  grammar = "_Tcl_Rules" #xxx should probably not hardcode this.
EOH

my $rule = join("",<RULES>);
$rule =~ s/\n//g;

while ($rule =~ m/rule\s+(\w+)\s*{\s*(.*?)\s*};?/g) {
  my $rule_name = $1;
  my $rule_def = $2;
  $rule_def =~ s:\s+: :g;    # remove extra whitespace
  $rule_def =~ s:\\:\\\\:g;
  $rule_def =~ s:":\\":g;

  $rules .= <<EORULE
  p6rule_compile("$rule_def", grammar, "$rule_name")
EORULE

};

$rules .= ".end\n";

=cut

$rules = q{};

my $fallbacks;

# For every builtin with an inline'd version and no interpreted version,
# create a shim for the interpreted version that automatically calls 
# the inline'd version, compiles the result and invokes it.

my @fallbacks = @blt_files;
foreach my $cmd (@cmd_files) {
  @fallbacks = grep { $_ ne $cmd } @fallbacks;
}

foreach my $fallback (@fallbacks) {
$fallbacks .= <<"END_PIR"
# fallback for interpreter: call the inlined version
.namespace [ 'Tcl' ]
.sub "&$fallback"
  .param pmc argv :slurpy
  .local pmc inlined, pir_compiler, invokable
  inlined = find_global '_Tcl::builtins', '$fallback'
  .local string pir_code
  .local int register_num
  (register_num,pir_code) = inlined(0,argv)
  pir_compiler = find_global '_Tcl', 'pir_compiler' 
  invokable = pir_compiler(register_num,pir_code)
  .return invokable()
.end
END_PIR
}

$contents =~ s/\${INCLUDES}/$includes/;
$contents =~ s/\${HEADER}/This file automatically generated by $0, do not edit/;
$contents =~ s/\${RULES}/$rules/;
$contents =~ s/\${FALLBACKS}/$fallbacks/;
$contents =~s/\${XXX.*}//g;

print $contents;