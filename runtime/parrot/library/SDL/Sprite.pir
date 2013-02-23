=head1 NAME

SDL::Sprite - Parrot class representing sprites in Parrot SDL

=head1 SYNOPSIS

	# load this library
	load_bytecode 'library/SDL/Sprite.pir'

	# ... load a new SDL::Image into image

	# set the sprite's arguments
	.local pmc sprite_args

	sprite_args = new PerlHash
	sprite_args[ 'surface'  ] = image
	sprite_args[ 'source_x' ] =     0
	sprite_args[ 'source_y' ] =     0
	sprite_args[ 'dest_x'   ] =   270
	sprite_args[ 'dest_y'   ] =   212
	sprite_args[ 'bgcolor'  ] = black

	# if the image has multiple tiles that represent animation frames, set the
	# width and height of each tile
	sprite_args[ 'width'    ] =   100
	sprite_args[ 'height'   ] =    56

	# create a new SDL::Sprite object
	.local pmc sprite
	.local int sprite_type

	find_type sprite_type, 'SDL::Sprite'
	sprite = new sprite_type, sprite_args

	# ... draw the sprite to surfaces as you will

=head1 DESCRIPTION

A SDL::Sprite object represents an image and its position.  By changing the
coordinates of the sprite, you'll change its position when it draws itself to a
surface.

This is a class in progress; it has to represent several different drawing
styles.

=head1 METHODS

A SDL::Sprite object has the following methods:

=over 4

=cut

.namespace [ 'SDL::Sprite' ]

.sub _initialize :load

	.local   pmc sprite_class
	newclass     sprite_class, 'SDL::Sprite'

	addattribute sprite_class, 'surface'
	addattribute sprite_class, 'source_rect'
	addattribute sprite_class, 'prev_rect'
	addattribute sprite_class, 'rect'
	addattribute sprite_class, 'bgcolor'
	addattribute sprite_class, 'drawn_rect'
	addattribute sprite_class, 'undrawn_rect'
	addattribute sprite_class, 'x_velocity'
	addattribute sprite_class, 'y_velocity'

	.local pmc initializer
	initializer = new PerlString
	set initializer, '_new'
	setprop sprite_class, 'BUILD', initializer

.end

=item _new( sprite_args )

Given a PerlHash full of arguments, sets the attributes of this object.  The
useful hash keys are as follows:

=over 4

=item surface

The SDL::Image from which to draw the sprite frames.

=item source_x

The x coordinate within the C<surface> from which to start drawing.

=item source_y

The y coordinate within the C<surface> from which to start drawing.

=item dest_x

The x coordinate within the destination surface to which to draw.

=item dest_y

The y coordinate within the destination surface to which to draw.

=item bgcolor

A SDL::Color object representing the background color of the main surface.
This will come in handy when drawing over the previous position of this sprite,
unless you redraw the entire surface on every frame.

=item width

The width of the image, in pixels, to draw.  If you have multiple frames of an
animation within the image provided, set the width here to the width of a
single frame.

If you don't set this value, this will use the current width of the image.

=item height

The height of the image, in pixels, to draw.  If you have multiple frames of an
animation within the image provided, set the height here to the height of a
single frame.

If you don't set this value, this will use the current height of the image.

=back

B<Note:>  I'm not completely thrilled with these arguments, so they may change
slightly.

The name of this method may change, as per discussion on p6i.

=cut

.sub _new method
	.param pmc args

	# set the surface attribute
	.local pmc surface
	surface = args[ 'surface' ]

	.local int offset
	classoffset offset, self, 'SDL::Sprite'
	setattribute self, offset, surface
	inc offset

	# set all of the rect attributes
	.local int rect_type
	find_type rect_type, 'SDL::Rect'

	.local int x
	.local int y
	.local int height
	.local int width

	x = args[ 'source_x' ]
	y = args[ 'source_y' ]

	exists $I0, args[ 'width' ]
	if $I0 goto width_arg

	width = surface.'width'()
	goto set_height

width_arg:
	width = args[ 'width' ]

set_height:
	exists $I0, args[ 'height' ]
	if $I0 goto height_arg

	height = surface.'height'()
	goto done

height_arg:
	height = args[ 'height' ]

done:
	.local pmc rect_args
	rect_args = new PerlHash
	rect_args[ 'x'      ] = x
	rect_args[ 'y'      ] = y
	rect_args[ 'height' ] = height
	rect_args[ 'width'  ] = width

	# first the source rectangle
	.local pmc source_rect

	source_rect = new rect_type, rect_args

	setattribute self, offset, source_rect
	inc offset

	# now the dest rectangle
	.local pmc rect

	x                = args[ 'dest_x' ]
	y                = args[ 'dest_y' ]
	rect_args[ 'x' ] = x
	rect_args[ 'y' ] = y

	rect = new rect_type, rect_args

	setattribute self, offset, rect
	inc offset

	# and now the previous rect
	.local pmc prev_rect
	prev_rect = new rect_type, rect_args

	setattribute self, offset, prev_rect
	inc offset

	# the background color
	.local pmc bgcolor
	bgcolor = args[ 'bgcolor' ]
	setattribute self, offset, bgcolor
	inc offset

	# the drawn rect
	.local pmc drawn_rect
	drawn_rect = new rect_type, rect_args
	setattribute self, offset, drawn_rect
	inc offset

	# the undrawn rect
	.local pmc undrawn_rect
	undrawn_rect = new rect_type, rect_args
	setattribute self, offset, undrawn_rect
	inc offset

	# and finally the x and y velocities
	.local pmc x_velocity
	x_velocity = new PerlInt
	x_velocity = 0
	setattribute self, offset, x_velocity
	inc offset

	.local pmc y_velocity
	y_velocity = new PerlInt
	y_velocity = 0
	setattribute self, offset, y_velocity

.end

=item draw_undraw( surface )

Draws the image this object represents to the given SDL::Surface.  This will
return two SDL::Rect objects, one representing the previous position of this
sprite and one representing the current position.  

Use this when dealing with a single-buffered main window.  You'll need to call
C<update_rect()> on the C<surface> to make things actually show up, if it's the
main surface.

Note that this will fill in the previous position with the background color set
in the constructor.

=cut

.sub draw_undraw method
	.param pmc dest_surface

	.local pmc surface
	.local pmc source_rect
	.local pmc rect
	.local pmc prev_rect
	.local pmc bgcolor

	.local pmc drawn_rect
	.local pmc undrawn_rect

	surface      = self.'surface'()
	source_rect  = self.'source_rect'()
	rect         = self.'rect'()
	prev_rect    = self.'prev_rect'()
	bgcolor      = self.'bgcolor'()

	drawn_rect   = self.'drawn_rect'()
	undrawn_rect = self.'undrawn_rect'()

	dest_surface.'fill_rect'( prev_rect, bgcolor )
	dest_surface.'blit'( surface, source_rect, rect )

	.local int x
	.local int y

	x = prev_rect.'x'()
	y = prev_rect.'y'()

	undrawn_rect.'x'( x )
	undrawn_rect.'y'( y )

	x = rect.'x'()
	y = rect.'y'()

	drawn_rect.'x'( x )
	drawn_rect.'y'( y )
	prev_rect.'x'( x )
	prev_rect.'y'( y )

	.pcc_begin_return
		.return drawn_rect
		.return undrawn_rect
	.pcc_end_return

.end

=item draw( surface )

Draws the image represented by this object to the given surface.  This will
also fill the previous position of the image with the background color.
(Arguably, this is not always right, but I know about it and will figure
something out, unless you have a better idea and let me know first.)

Use this when dealing with a double-buffered main window.  In that case, you
will have to call C<flip()> on the C<surface> yourself to make your changes
appear.

=cut

.sub draw method
	.param pmc dest_surface

	.local pmc surface
	.local pmc source_rect
	.local pmc rect
	.local pmc prev_rect
	.local pmc bgcolor

	surface      = self.'surface'()
	source_rect  = self.'source_rect'()
	rect         = self.'rect'()
	prev_rect    = self.'prev_rect'()
	bgcolor      = self.'bgcolor'()

	dest_surface.'fill_rect'( prev_rect, bgcolor )
	dest_surface.'blit'( surface, source_rect, rect )

	.local int x
	.local int y
	x = rect.'x'()
	y = rect.'y'()
	prev_rect.'x'( x )
	prev_rect.'y'( y )

.end

=item surface()

Returns the underlying surface of the image represented by this class.  You
should never need to call this directly, unless you're working with the raw SDL
functions.

=cut

.sub surface method
	.local int offset
	classoffset offset, self, 'SDL::Sprite'

	.local pmc surface
	getattribute surface, self, offset

	.pcc_begin_return
		.return surface
	.pcc_end_return
.end

=item source_rect()

Returns the SDL::Rect object representing the source from which to draw within
the underlying image.

You should never need to call this directly.

=cut

.sub source_rect method
	.local int offset
	classoffset offset, self, 'SDL::Sprite'
	add offset, 1

	.local pmc source_rect
	getattribute source_rect, self, offset

	.pcc_begin_return
		.return source_rect
	.pcc_end_return
.end

=item prev_rect()

Returns the SDL::Rect representing the previous position of this sprite within
a destination surface.

You should never need to call this directly.

=cut

.sub prev_rect method
	.local int offset
	classoffset offset, self, 'SDL::Sprite'
	add offset, 2

	.local pmc prev_rect
	getattribute prev_rect, self, offset

	.pcc_begin_return
		.return prev_rect
	.pcc_end_return
.end

=item rect()

Returns the SDL::Rect representing this sprite's current position within the
destination surface.

You should never need to call this directly.

=cut

.sub rect method
	.local int offset
	classoffset offset, self, 'SDL::Sprite'
	add offset, 3

	.local pmc rect
	getattribute rect, self, offset

	.pcc_begin_return
		.return rect
	.pcc_end_return
.end

=item bgcolor()

Returns the SDL::Color object representing the background color to draw to the
destination when undrawing the previous position of this sprite.

You should never need to call this directly.

=cut

.sub bgcolor method
	.local int offset
	classoffset offset, self, 'SDL::Sprite'
	add offset, 4

	.local pmc bgcolor
	getattribute bgcolor, self, offset

	.pcc_begin_return
		.return bgcolor
	.pcc_end_return
.end

=item drawn_rect()

Returns the SDL::Rect representing the current position of the sprite within
the destination surface as of the current drawing operation.

You should I<never> need to call this directly.  I mean it.  This may go away
suddenly in a brilliant flash of insight.

=cut

.sub drawn_rect method
	.local int offset
	classoffset offset, self, 'SDL::Sprite'
	add offset, 5

	.local pmc drawn_rect
	getattribute drawn_rect, self, offset

	.pcc_begin_return
		.return drawn_rect
	.pcc_end_return
.end

=item undrawn_rect()

Returns the SDL::Rect representing the previous position of the sprite within
the destination surface as of the current drawing operation.

You should I<never> need to call this directly.  I mean it.  This may go away
suddenly in a brilliant flash of insight.

=cut

.sub undrawn_rect method
	.local int offset
	classoffset offset, self, 'SDL::Sprite'
	add offset, 6

	.local pmc undrawn_rect
	getattribute undrawn_rect, self, offset

	.pcc_begin_return
		.return undrawn_rect
	.pcc_end_return
.end

=item x( [ new_x_coordinate ] )

Gets and sets the x coordinate of this sprite within the destination surface,
in pixels.  This is always an integer.

=cut

.sub x method
	.param int new_x

	.local int param_count
	.local pmc rect

	param_count = I1
	rect = self.'rect'()

	if param_count == 0 goto getter
	rect.'x'( new_x )

getter:
	.local int result
	result = rect.'x'()

	.pcc_begin_return
		.return result
	.pcc_end_return
.end

=item y( [ new_y_coordinate ] )

Gets and sets the y coordinate of this sprite within the destination surface,
in pixels.  This is always an integer.

=cut

.sub y method
	.param int new_y

	.local int param_count
	.local pmc rect

	param_count = I1
	rect = self.'rect'()

	if param_count == 0 goto getter
	rect.'y'( new_y )

getter:
	.local int result
	result = rect.'y'()

	.pcc_begin_return
		.return result
	.pcc_end_return
.end

=item x_velocity( [ new_x_velocity ] )

Gets and sets the x velocity of this sprite.  This is always an integer.

Maybe this method shouldn't be here; it may move.

=cut

.sub x_velocity method
	.param int new_x_vel

	.local int offset
	classoffset offset, self, 'SDL::Sprite'
	add offset, 7

	.local pmc x_vel
	getattribute x_vel, self, offset

	.local int param_count
	.local pmc rect

	param_count = I1

	if param_count == 0 goto getter
	x_vel = new_x_vel

getter:
	.local int result
	result = x_vel

	.pcc_begin_return
		.return result
	.pcc_end_return
.end

=item y_velocity( [ new_y_velocity ] )

Gets and sets the y velocity of this sprite.  This is always an integer.

Maybe this method shouldn't be here; it may move.

=cut

.sub y_velocity method
	.param int new_y_vel

	.local int offset
	classoffset offset, self, 'SDL::Sprite'
	add offset, 8

	.local pmc y_vel
	getattribute y_vel, self, offset

	.local int param_count
	.local pmc rect

	param_count = I1

	if param_count == 0 goto getter
	y_vel = new_y_vel

getter:
	.local int result
	result = y_vel

	.pcc_begin_return
		.return result
	.pcc_end_return
.end

=back

=head1 AUTHOR

Written and maintained by chromatic, E<lt>chromatic at wgz dot orgE<gt>, with
suggestions from Jens Rieks.  Please send patches, feedback, and suggestions to
the Perl 6 Internals mailing list.

=head1 COPYRIGHT

Copyright (c) 2004, The Perl Foundation.

=cut