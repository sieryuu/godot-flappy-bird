extends Node2D

@export var obstacle_scene: PackedScene

const min_obstacle_y = -250
const max_obstacle_y = -80
const obstacle_distance = 180

var screen_size
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

	
func _spawn_obstacle():
	var obstacle = obstacle_scene.instantiate()
	
	# set obstacle x position
	obstacle.position.x = screen_size.x
	
	# set obstacle y position
	var random_y = randf_range(min_obstacle_y, max_obstacle_y)
	obstacle.position.y = random_y
	
	obstacle.connect('pass_obstacle', _obstacle_pass)
	
	add_child(obstacle)

func _obstacle_pass():
	print_debug('pass')
	score += 1
	$ScoreSound.play()
	$HUD.update_score(score)

func _start_game():
	$HUD.start_game()
	$SpawnObstacleTimer.start()
	score = 0

func _on_spawn_obstacle_timer_timeout():
	_spawn_obstacle()

func _on_player_hit():
	$Background.stop()
	$HUD.game_over()
	$SpawnObstacleTimer.stop()
	$HitSound.play()
 
func _new_game():
	$Player.reset()
	$HUD.new_game()
	$Background.move()
	get_tree().call_group("obstacle", "queue_free")
