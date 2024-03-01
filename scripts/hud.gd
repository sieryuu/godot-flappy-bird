extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_game():
	$WelcomeScreen.hide()
	$ScoreLabel.show()

func new_game():
	$WelcomeScreen.show()
	$ScoreLabel.hide()
	$Gameover.hide()
	update_score(0)

func game_over():
	$Gameover.show()

func update_score(score):
	$ScoreLabel.update_score(score)
	
