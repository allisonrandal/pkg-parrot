=head1 TITLE

blue_font.pir - draw a friendly message to the screen

=head1 SYNOPSIS

To run this file, run the following command from the Parrot directory:

	$ ./parrot examples/sdl/blue_font.pir
	$

Note that you'll need a font named C<times.ttf> in the current directory.  I
recommend making a symlink.

Yes, getting this to work across platforms is tricky, as is distributing a
royalty-free font file.  Maybe soon.

=cut

.sub _main :main

	# first load the necessary libraries
	load_bytecode "library/SDL/App.pir"
	load_bytecode "library/SDL/Rect.pir"
	load_bytecode "library/SDL/Color.pir"
	load_bytecode "library/SDL/Font.pir"

	# arguments for the SDL::App constructor
	.local pmc args
	args             = new PerlHash
	args[ 'height' ] = 480
	args[ 'width'  ] = 640
	args[ 'bpp'    ] =   0
	args[ 'flags'  ] =   1

	# create an SDL::App object
	.local pmc app
	.local int app_type

	find_type app_type, 'SDL::App'
	app = new app_type, args

	# fetch the SDL::Surface representing the main window
	.local pmc main_screen
	main_screen = app.'surface'()

	# arguments for the SDL::Rect constructor
	args             = new PerlHash
	args[ 'height' ] = 100
	args[ 'width'  ] = 100
	args[ 'x'      ] = 194
	args[ 'y'      ] = 208

	# create an SDL::Rect object
	.local pmc rect
	.local int rect_type

	find_type rect_type, 'SDL::Rect'
	new rect, rect_type, args

	# create SDL::Color objects
	.local pmc blue
	.local pmc white
	.local int color_type

	find_type color_type, 'SDL::Color'

	args = new PerlHash
	set args[ 'r' ],   0
	set args[ 'g' ],   0
	set args[ 'b' ], 255

	new blue, color_type, args

	args = new PerlHash
	set args[ 'r' ], 255
	set args[ 'g' ], 255
	set args[ 'b' ], 255
	new white, color_type, args

	args[ 'font_file'  ] = 'times.ttf'
	args[ 'point_size' ] = 48

	.local pmc font
	.local int font_type
	find_type  font_type, 'SDL::Font'
	new font,  font_type, args

	.local pmc full_rect
	args = new PerlHash
	args[ 'width'  ] = 640
	args[ 'height' ] = 480
	args[ 'x'      ] = 0
	args[ 'y'      ] = 0

	full_rect = new rect_type, args
	main_screen.'fill_rect'( full_rect, white )
	main_screen.'update_rect'( full_rect )

	# draw the rectangle to the surface and update it

	font.'draw'( 'Hello, world!', blue, main_screen, rect )
	main_screen.'update_rect'( rect )

	# pause for people to see it
	sleep 2

	# and that's it!
	app.'quit'()
	end
.end

=head1 AUTHOR

chromatic, E<lt>chromatic at wgz dot orgE<gt>.

=head1 COPYRIGHT

Copyright (c) 2004, the Perl Foundation.

=cut