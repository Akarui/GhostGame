extends Node2D

var shelf_scene = load("res://scenes/shelf.tscn")
@onready var shelf_viewport: SubViewport = $BookShelfCanvasLayer/SubViewportContainer/SubViewport
@onready var shelf: Node2D = $BookShelfCanvasLayer/SubViewportContainer/SubViewport/Shelf

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#var shelf_instance = shelf_scene.instantiate()
	#shelf_instance.name = "shelf"
	#shelf_instance.position = Vector2(320, 180)
	#add_child(shelf_instance)


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
			
