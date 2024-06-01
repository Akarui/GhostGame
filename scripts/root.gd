extends Node2D

@onready var shelf_viewport: SubViewport = $BookShelfCanvasLayer/SubViewportContainer/SubViewport
@onready var shelf: Node2D = $BookShelfCanvasLayer/SubViewportContainer/SubViewport/Shelf

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
	if Input.is_action_just_pressed("open_shelf"):
		if shelf_viewport.get_child_count() > 0:
			shelf_viewport.get_child(0).queue_free()
			$BookShelfCanvasLayer.visible = false
		else:
			var shelf_instance = shelf_scene.instantiate()
			shelf_viewport.add_child(shelf_instance)
			$BookShelfCanvasLayer.visible = true
			print("gotta shelf: " + str(shelf))
			
