extends PanelContainer

@export var numbers: Array[CompressedTexture2D] = []

var word_spacing = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	update_score(0)
	

func update_score(score: int):
	for child in get_children():
		remove_child(child)
		child.queue_free()
			
	var pos_x = 0
	var label_width = 0
	#loop each characters and add sprites to child
	var sprites: Array[Sprite2D] = []
	for x in str(score):
		var sprite = Sprite2D.new()
		sprite.set_texture(numbers[int(x)])	
		sprites.append(sprite)
		label_width += sprite.get_rect().size.x + word_spacing
	
	# minus last wordspacing to be more center	
	pos_x -= (label_width - word_spacing) / 2
	for sprite in sprites:
		sprite.position.x = pos_x
		add_child(sprite)
		pos_x += sprite.get_rect().size.x + word_spacing
