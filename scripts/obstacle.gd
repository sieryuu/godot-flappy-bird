extends Area2D

signal pass_obstacle

var is_moving = true
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("/root/Main/Player")
	player.connect('hit', Callable(self, "stop"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_moving:
		position.x -= 1

func _on_visible_on_screen_notifier_2d_screen_exited():
	print_debug('freeing obstacle')
	queue_free()

func stop():
	is_moving = false

func _on_body_entered(body):
	pass_obstacle.emit()
