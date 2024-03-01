extends Node2D

var screen_size

var is_game_over = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_parent().get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_game_over:
		return
	
	# move background
	position.x -= 1
	
	# reset background position
	if position.x == -screen_size.x:
		position.x = 0

func stop():
	is_game_over = true

func move():
	is_game_over = false
