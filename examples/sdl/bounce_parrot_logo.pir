=head1 TITLE

bounce_parrot_logo.pir - bounce a Parrot logo with the SDL Parrot bindings

=head1 SYNOPSIS

To run this file, run the following command from the Parrot directory:

	$ parrot examples/sdl/bounce_parrot_logo.pir
	$

You'll see the happy Parrot logo in the middle of a new SDL window.  Use the
cursor keys to apply velocity in the appropriate directions.  Watch it bounce!
Use the Escape key or close the window when you've had enough.

=cut

.sub _main :main
	load_bytecode "library/SDL/App.pir"
	load_bytecode "library/SDL/Color.pir"
	load_bytecode "library/SDL/Rect.pir"
	load_bytecode "library/SDL/Image.pir"
	load_bytecode "library/SDL/Sprite.pir"
	load_bytecode "library/SDL/EventHandler.pir"
	load_bytecode "library/SDL/Event.pir"

	.local pmc app_args
	new app_args, .PerlHash
	set app_args[ 'width'  ], 640
	set app_args[ 'height' ], 480
	set app_args[ 'bpp'    ],   0
	set app_args[ 'flags'  ],   0

	.local pmc app
	.local int app_type

	find_type app_type, 'SDL::App'
	app = new app_type, app_args

	.local pmc main_screen
	main_screen = app.'surface'()

	.local pmc color_args
	color_args = new PerlHash

	color_args[ 'r' ] = 0
	color_args[ 'g' ] = 0
	color_args[ 'b' ] = 0

	.local pmc black
	.local int color_type

	find_type color_type, 'SDL::Color'
	black = new color_type, color_args

	.local pmc image
	.local int image_type
	.local pmc filename

	new filename, .PerlString
	filename = 'examples/sdl/parrot_small.png'

	find_type image_type, 'SDL::Image'
	image = new image_type, filename

	.local pmc sprite_args
	sprite_args = new PerlHash
	sprite_args[ 'surface'  ] = image
	sprite_args[ 'source_x' ] =     0
	sprite_args[ 'source_y' ] =     0
	sprite_args[ 'dest_x'   ] =   270
	sprite_args[ 'dest_y'   ] =   212
	sprite_args[ 'bgcolor'  ] = black

	.local pmc sprite
	.local int sprite_type

	find_type sprite_type, 'SDL::Sprite'
	sprite = new sprite_type, sprite_args

	_main_loop( main_screen, sprite )

.end

.sub _main_loop
	.param pmc main_screen
	.param pmc sprite

	.local pmc parent_class
	.local pmc class_type
	getclass parent_class, 'SDL::EventHandler'
	subclass class_type, parent_class, 'MoveLogo::EventHandler'

	.local pmc event_handler
	.local int handler_type

	find_type handler_type, 'MoveLogo::EventHandler'
	event_handler = new handler_type

	.local pmc event
	.local int event_type

	find_type event_type, 'SDL::Event'
	event = new event_type

	.local pmc handler_args
	handler_args = new .PerlHash
	handler_args[ 'screen' ] = main_screen
	handler_args[ 'sprite' ] = sprite

	.local num last_time
	last_time = time

	.local num counter
	counter = 0

	.local num current_time
	current_time = 0

	.local int frame_count
	frame_count = 1

	.local int updated
	event_handler.'draw_screen'( main_screen, sprite )

loop:
	last_time = current_time
	updated   = event_handler.'update_position'( sprite, frame_count )

	if updated == 0 goto increase_count

	event_handler.'draw_screen'( main_screen, sprite )

increase_count:
	inc frame_count
	if  frame_count < 6 goto get_event
	frame_count = 0

get_event:
	event.'handle_event'( event_handler, handler_args )

	current_time = time
	counter      = current_time - last_time

	if counter < 0.016 goto get_event
	goto loop

.end

.namespace [ 'MoveLogo::EventHandler' ]

.sub update_position method
	.param pmc sprite
	.param int frame_count

	.local int updated
	updated = 0

	.local int x_velocity
	.local int y_velocity

	x_velocity = sprite.'x_velocity'()
	y_velocity = sprite.'y_velocity'()

	.local int abs_velocity
	.local int delta

check_x_update:
	if x_velocity == 0 goto check_y_update

	abs abs_velocity, x_velocity
	set delta, frame_count
	sub delta, abs_velocity

	if delta        > 0 goto check_y_update

	updated = 1

	if x_velocity   < 0 goto neg_x_dir

	self.'move_sprite_x'( sprite,  1 )
	goto check_y_update

neg_x_dir:
	self.'move_sprite_x'( sprite, -1 )

check_y_update:
	if y_velocity == 0 goto return

	abs abs_velocity, y_velocity
	set delta, frame_count
	sub delta, abs_velocity

	if delta      > 0 goto return

	updated = 1

	if y_velocity < 0 goto neg_y_dir

	self.'move_sprite_y'( sprite,  1 )
	goto return

neg_y_dir:
	self.'move_sprite_y'( sprite, -1 )

return:
	.pcc_begin_return
		.return updated
	.pcc_end_return

.end

.sub draw_screen method
	.param pmc screen
	.param pmc sprite

	.local pmc prev_rect
	.local pmc rect
	.local pmc rect_array
	rect_array = new Array
	set rect_array, 2

	(prev_rect, rect) = sprite.'draw_undraw'( screen )
	set rect_array[ 0 ], prev_rect
	set rect_array[ 1 ], rect

	screen.'update_rects'( rect_array )
#	screen.'update_rect'( rect )

.end

.sub move_sprite_x method
	.param pmc sprite
	.param int direction

	.local int x
	x = sprite.'x'()

	add x, direction

	if x >= 0 goto check_x_max
	x = 0
	goto x_bounce

check_x_max:
	if x < 540 goto x_update
	x = 540

x_bounce:
	.local int x_velocity
	x_velocity = sprite.'x_velocity'()
	x_velocity = -x_velocity
	sprite.'x_velocity'( x_velocity )

x_update:
	sprite.'x'( x )

.end

.sub move_sprite_y method
	.param pmc sprite
	.param int direction

	.local int y
	y = sprite.'y'()

	add y, direction

	if y >= 0 goto check_y_max
	y = 0
	goto y_bounce

check_y_max:
	if y < 424 goto y_update
	y = 424

y_bounce:
	.local int y_velocity
	y_velocity = sprite.'y_velocity'()
	y_velocity = -y_velocity
	sprite.'y_velocity'( y_velocity )

y_update:
	sprite.'y'( y )

.end

.sub key_down_down method
	.param pmc event_args

	.local pmc screen
	.local pmc sprite

	screen = event_args[ 'screen' ]
	sprite = event_args[ 'sprite' ]

	.local int y_vel
	y_vel = sprite.'y_velocity'()

	if  y_vel == 5 goto return
	inc y_vel

	sprite.'y_velocity'( y_vel )

return:

.end

.sub key_down_up method
	.param pmc event_args

	.local pmc screen
	.local pmc sprite

	screen = event_args[ 'screen' ]
	sprite = event_args[ 'sprite' ]

	.local int y_vel
	y_vel = sprite.'y_velocity'()

	if  y_vel == -5 goto return
	dec y_vel

	sprite.'y_velocity'( y_vel )

return:

.end

.sub key_down_left method
	.param pmc event_args

	.local pmc screen
	.local pmc sprite

	screen = event_args[ 'screen' ]
	sprite = event_args[ 'sprite' ]

	.local int x_vel
	x_vel = sprite.'x_velocity'()

	if  x_vel == -5 goto return
	dec x_vel

	sprite.'x_velocity'( x_vel )

return:

.end

.sub key_down_right method
	.param pmc event_args

	.local pmc screen
	.local pmc sprite

	screen = event_args[ 'screen' ]
	sprite = event_args[ 'sprite' ]

	.local int x_vel
	x_vel = sprite.'x_velocity'()

	if  x_vel == 5 goto return
	inc x_vel

	sprite.'x_velocity'( x_vel )

return:

.end

.sub key_down_escape method
	.param pmc event_args

	# XXX: a silly way to quit
	end
.end

=head1 AUTHOR

chromatic, E<lt>chromatic at wgz dot orgE<gt>.

=head1 COPYRIGHT

Copyright (c) 2004, The Perl Foundation.

=cut