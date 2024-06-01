extends Node2D

@onready var cover: Sprite2D = $Sprite/Cover
@onready var pages: Sprite2D = $Sprite/Pages
@onready var anim: AnimationPlayer = $AnimationPlayer

@export var cover_color: Color:
	set(v):
		cover_color = v
		$Sprite/Cover.modulate = v

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func highlight():
	if anim.get_queue().size() > 1:
		return
	anim.queue("highlight",)

	
func unhighlight():
	anim.queue("unhighlight")
