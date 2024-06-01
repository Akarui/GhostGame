extends Node2D

@onready var cover: Sprite2D = $Sprite/Cover
@onready var pages: Sprite2D = $Sprite/Pages
@onready var anim: AnimationPlayer = $AnimationPlayer

@export var cover_color: Color:
	set(v):
		cover_color = v
		$Sprite/Cover.modulate = v

var is_lifted = false

func _ready():
	pass # Replace with function body.

func _process(delta):
	$Sprite/Label.set_position(position, true)
	$Sprite/Label.text = str(get_index())
	
func shift_right():
	print("anim shift_right")
	var parent = get_parent().get_parent()
	var loci = parent.get_loci()
	position = loci[get_index()]
	
func shift_left():
	print("anim shift_left")
	var parent = get_parent().get_parent()
	var loci = parent.get_loci()
	position = loci[get_index()]

func highlight():
	anim.queue("highlight")
	print("anim highlight")

func unhighlight():
	anim.queue("unhighlight")
	print("anim unhighlight")
	
func lift():
	anim.queue("lift")
	is_lifted = true
	print("anim lift")
	
func drop():
	anim.queue("drop")
	is_lifted = false
	print("anim drop")
	
func budge():
	if anim.get_queue().size() > 1:
		return
	anim.queue("budge")
	print("anim budge")
