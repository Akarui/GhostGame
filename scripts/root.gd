extends Node2D

var shelf_scene = load("res://scenes/shelf.tscn")
var wanderer_scene = load("res://scenes/wanderer.tscn")
var player_scene = load("res://scenes/player.tscn")
#var has_shelf = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var wanderer_instance = wanderer_scene.instantiate()
	wanderer_instance.name = "wanderer"
	add_child(wanderer_instance)
	
	var player_instance = player_scene.instantiate()
	player_instance.name = "player"
	add_child(player_instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#if Input.is_action_pressed("ui_accept"):
		#if has_shelf == true:
			#find_child("shelf").queue_free()
			#has_shelf = false
		#else:
			#var shelf_instance = shelf_scene.instantiate()
			#shelf_instance.name = "shelf"
			#shelf_instance.position = Vector2(320, 180)
			#add_child(shelf_instance)
			#has_shelf == true
			
