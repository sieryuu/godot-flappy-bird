extends CharacterBody2D

signal start_game
signal new_game
signal hit

const JUMP_VELOCITY = -280.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var screen_size
var player_default_pos = Vector2(45, 256)
var is_game_start = false
var is_player_hit = false

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	# stop if player hit any obstacle
	if is_player_hit:
		_process_player_hit()
		return
	
	# Handle jump 
	if Input.is_action_just_pressed("ui_accept"):
		if not is_game_start:
			is_game_start = true
			start_game.emit()
		
		velocity.y = JUMP_VELOCITY
		$WingSound.play()

	# ignore gravity if game is not started
	if not is_game_start:
		return
		
	# Add the gravity.
	velocity.y += gravity * delta
		
	if velocity.y > 0:
		$AnimatedSprite2D.animation = "up"
		set_rotation_degrees(35)
	else:
		$AnimatedSprite2D.animation = "down"
		set_rotation_degrees(-35)

	var collision = move_and_collide(velocity * delta)
	if collision:
		_player_hit()
		
	# prevent bird going above sky
	position = position.clamp(Vector2.ZERO, screen_size)
		
func reset():
	is_player_hit = false
	is_game_start = false
	
	# reset player position
	position = player_default_pos
	$AnimatedSprite2D.play()
	set_rotation_degrees(0)
		
func _process_player_hit():
	$AnimatedSprite2D.stop()
	if Input.is_action_just_pressed("ui_accept") and $DeathCooldown.is_stopped():
		new_game.emit()
		
func _player_hit():
	is_player_hit = true
	hit.emit()
	$DeathCooldown.start()

