extends Node2D

#@onready var shelf_viewport: SubViewport = $BookShelfCanvasLayer/SubViewportContainer/SubViewport
#@onready var shelf: Node2D = $BookShelfCanvasLayer/SubViewportContainer/SubViewport/Shelf

@onready var shelf_list: Node = $ShelfList

var shelf_scene = load("res://scenes/shelf.tscn")
var wanderer_scene = load("res://scenes/wanderer.tscn")
var player_scene = load("res://scenes/player.tscn")

var shelf_mode = false
var player_shelf = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var wanderer_instance = wanderer_scene.instantiate()
	wanderer_instance.name = "wanderer"
	add_child(wanderer_instance)
	
	var player_instance = player_scene.instantiate()
	player_instance.name = "player"
	add_child(player_instance)
	
	gen_shelves($ShelfAccessorList.get_child_count())
	for shelf in shelf_list.get_children():
		print(shelf.get_book_titles())
		
	#verify_shelves()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("open_shelf"):
		# check for active shelf
		if shelf_mode and player_shelf < 0:
			print("ERROR: shouldn't be in shelf_mode without a player_shelf defined")
			get_tree().quit()
		if not shelf_mode and player_shelf > -1:
			shelf_mode = true
			shelf_list.get_child(player_shelf).open()
			#player.can_move = false
		elif shelf_mode:
			shelf_mode = false
			shelf_list.get_child(player_shelf).close()
			#player.can_move = true
			
		
		#if shelf_viewport.get_child_count() > 0:
			#shelf_viewport.get_child(0).check_shelving()
			#shelf_viewport.get_child(0).queue_free()
			#$BookShelfCanvasLayer.visible = false
		#else:
			#var shelf_instance = shelf_scene.instantiate()
			#shelf_viewport.add_child(shelf_instance)
			#$BookShelfCanvasLayer.visible = true
			
func gen_shelves(quantity):
	for i in range(quantity):
		var shelf = shelf_scene.instantiate()
		shelf_list.add_child(shelf)
	
func verify_shelves():
	var total_mistakes = 0
	for shelf in shelf_list.get_children():
		total_mistakes += shelf.check_shelving()
	print("TOTAL MISTAKES: %d" % total_mistakes)
	return total_mistakes
	
func set_player_shelf(index):
	player_shelf = index

