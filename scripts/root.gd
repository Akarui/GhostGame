extends Node2D

#@onready var shelf_viewport: SubViewport = $BookShelfCanvasLayer/SubViewportContainer/SubViewport
#@onready var shelf: Node2D = $BookShelfCanvasLayer/SubViewportContainer/SubViewport/Shelf
@onready var shelf: Node2D = $Shelf
@onready var wanderer: Node2D = $Wanderer
@onready var player: Node2D = $Player

var shelf_scene = load("res://scenes/shelf.tscn")
var wanderer_scene = load("res://scenes/wanderer.tscn")
var player_scene = load("res://scenes/player.tscn")

var shelf_mode = false

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("open_shelf"):
		if not shelf_mode:
			shelf_mode = true
			shelf.open()
			player.can_move = false
			
			
		
		#if shelf_viewport.get_child_count() > 0:
			#shelf_viewport.get_child(0).check_shelving()
			#shelf_viewport.get_child(0).queue_free()
			#$BookShelfCanvasLayer.visible = false
		#else:
			#var shelf_instance = shelf_scene.instantiate()
			#shelf_viewport.add_child(shelf_instance)
			#$BookShelfCanvasLayer.visible = true
			
