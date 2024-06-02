extends Node2D


@onready var wanderer: Node2D = $CanvasGroup/Wanderer
@onready var player: Node2D = $CanvasGroup/Player
@onready var shelf_list: Node = $ShelfList

var shelf_scene = load("res://scenes/shelf.tscn")
var wanderer_scene = load("res://scenes/wanderer.tscn")
var player_scene = load("res://scenes/player.tscn")

var shelf_mode = false
var dark_mode = false
var isPaused = false
var trueEnd = false
var player_shelf = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasModulate.visible = false
	$EndTitle.visible = false
	randomize()
	
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
		elif not shelf_mode and player_shelf > -1:
			shelf_mode = true
			shelf_list.get_child(player_shelf).open()
			player.can_move = false
			if dark_mode:
				shelf.activateDarkMode()
		elif shelf_mode:
			shelf_mode = false
			shelf_list.get_child(player_shelf).close()
			player.can_move = true
			# turn off darkmode?
			
	if (player.get_game_over() || wanderer.is_game_over()) && $Cooldown.is_ready:
		if !dark_mode:
			$Cooldown.start_timer()
			player.reset()
			wanderer.reset()
			dark_mode = true
			player.activateDarkMode(true)
			$CanvasModulate.visible = true
			player.game_over = false
			wanderer.set_game_over(false)
			$EndTitle.visible = true
		else:
			trueEnd = true
			$EndTitle.visible = true
			player.visible = false
	
	if $EndTitle.visible && !trueEnd && $Cooldown.is_ready:
		if Input.is_anything_pressed():
			$EndTitle.visible = false
			
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

