extends Node2D

@onready var cover: Sprite2D = $Sprite/Cover
@onready var pages: Sprite2D = $Sprite/Pages
@onready var anim: AnimationPlayer = $AnimationPlayer

@export var cover_color: Color:
	set(v):
		cover_color = v
		$Sprite/Cover.modulate = v

var is_lifted = false

var title: String
var clean_title: String
var pub_year: String
var author_name: String
#var letter: String

	
func customize(data):
	title = data.title
	pub_year = data.pub_year
	author_name = data.author_name
	
	if title.to_upper().begins_with("THE "):
		clean_title = title.substr(4).to_upper()
		#letter = title[4].to_upper()
	elif title.to_upper().begins_with("AN "):
		clean_title = title.substr(3).to_upper()
		#letter = title[3].to_upper()
	elif title.to_upper().begins_with("A "):
		clean_title = title.substr(2).to_upper()
		#letter = title[2].to_upper()
	else:
		clean_title = title.substr(0).to_upper()
		#letter = title[0].to_upper()
	
	#letter = clean_title[0]
	#$Sprite/Label.text = letter
	$Sprite/Label.text = clean_title[0]
	
func shift_right():
	#print("anim shift_right")
	var parent = get_parent().get_parent()
	var loci = parent.get_loci()
	position = loci[get_index()]
	
func shift_left():
	#print("anim shift_left")
	var parent = get_parent().get_parent()
	var loci = parent.get_loci()
	position = loci[get_index()]

func highlight():
	anim.queue("highlight")
	#print("anim highlight")

func unhighlight():
	anim.queue("unhighlight")
	#print("anim unhighlight")
	
func lift():
	anim.queue("lift")
	is_lifted = true
	#print("anim lift")
	
func drop():
	anim.queue("drop")
	is_lifted = false
	#print("anim drop")
	
func budge():
	if anim.get_queue().size() > 1:
		return
	anim.queue("budge")
	#print("anim budge")
	
func lifted_budge():
	if anim.get_queue().size() > 1:
		return
	anim.queue("lifted_budge")
	#print("anim lifted_budge")
