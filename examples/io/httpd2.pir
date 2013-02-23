# Copyright (C) 2006-2007, The Perl Foundation.
# $Id: /parrotcode/local/examples/io/httpd2.pir 2657 2007-03-31T01:57:48.733769Z chromatic  $

=head1 NAME

httpd2.pir - A Simple Driver for ['HTTPD'; 'Daemon']

=head1 AUTHOR

Leopold Toetsch <lt@toetsch.at> - some code base on httpd.pir.

=cut

.sub main :main
    .param pmc args
    load_bytecode "HTTP/Daemon.pir"
    load_bytecode 'Getopt/Obj.pbc'

    .local pmc d, opts
    .local int clid
    opts = 'get_config'(args)
    clid = find_type ['HTTP'; 'Daemon']
    d = new clid, opts
    unless d goto err
    push_eh ignore
    $S0 = opts['url']
    if $S0 goto has_url
    $S0 = '.'
has_url:
    d.'url'($S0)
    d.'run'()
ignore:
    d.'shutdown'()
    end
err:
    printerr "Starting failed\n"
    exit 1
.end

.sub 'get_config'
    .param pmc args
    .local pmc getopts, opts, arg0
    getopts = new 'Getopt::Obj'
    push getopts, 'port|p=i'
    push getopts, 'host|h=s'
    push getopts, 'debug|d'
    push getopts, 'help|h'
    push getopts, 'url=s'
    push getopts, 'parrot-docs'
    arg0 = shift args
    opts = getopts.'get_options'(args)
    $I0 = opts['help']
    unless $I0 goto no_help
    'help'(arg0)
no_help:
    $I0 = opts['port']
    if $I0 goto has_port
    $I0 = 1234
has_port:
    opts['LocalPort'] = $I0
    $S0 = opts['host']
    if $S0 goto has_host
    $S0 = 'localhost'
has_host:
    opts['LocalAddr'] = $S0
    .return (opts)
.end

.sub 'help'
    .param pmc arg0
    print "Usage: ./parrot "
    print arg0
    print <<"EOP" 
 options ...

Valid options are: 

    [ --port|p=<port> ]     default 1234
    [ --host|h=<host> ]     default 'localhost'
    [ --debug ]             print internal diagnostics
    [ --parrot-docs ]       serve docs/html
EOP
    exit 0
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4: