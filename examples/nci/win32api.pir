# Copyright (C) 2001-2003 The Perl Foundation.  All rights reserved.
# $Id: win32api.pir 10739 2005-12-28 18:56:46Z particle $

=head1 NAME

examples/nci/win32api.pir - Win32 Example

=head1 SYNOPSIS

    % ./parrot examples/nci/win32api.pir

=head1 DESCRIPTION

This example calls the MessageBoxA Win32 API using the Parrot Native
Call Interface.  The function is defined as:-

    int MessageBox(
        HWND hWnd,
        LPCTSTR lpText,
        LPCTSTR lpCaption,
        UINT uType
    );

=cut

# This is the entry point.
.sub _MAIN
	# Load user32.dll library and the MessageBoxA API.
	.local pmc libuser32
	.local pmc MessageBoxA
	loadlib libuser32, "user32"
	dlfunc MessageBoxA, libuser32, "MessageBoxA", "llttl"
	
	# Set up parameters for the message box.
	.local int phWnd
	.local string message
	.local string caption
	.local int style
	phWnd = 0	# Parent window handle - we have none.
	message = "This is a message from Parrot!"
	caption = "Hey, you!"
	style = 64  # This gives us a nice i in a speech bubble icon.
	
	# Invoke MessageBoxA.
	.local int retVal
	.pcc_begin
		.arg phWnd
		.arg message
		.arg caption
		.arg style
		.nci_call MessageBoxA
		.result retVal
	.pcc_end
	
	# That's all, folks.
	end
.end

=head1 SEE ALSO

F<docs/pdds/pdd03_calling_conventions.pod>.

=cut