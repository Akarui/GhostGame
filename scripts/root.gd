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
var timeout = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasModulate.visible = false
	$EndTitle.visible = false
	randomize()
	
	gen_shelves($ShelfAccessorList.get_child_count())
	for shelf in shelf_list.get_children():
		print(shelf.get_book_titles())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HUD/RoundTimerLabel.text = str(snapped($RoundTimer.time_left, 1))
	
	if Input.is_action_just_pressed("menu"):
		# pause
		get_tree().quit()
		
	if Input.is_action_just_pressed("open_shelf"):
		# check for active shelf
		if shelf_mode and player_shelf < 0:
			print("ERROR: shouldn't be in shelf_mode without a player_shelf defined")
			get_tree().quit()
		elif not shelf_mode and player_shelf > -1 and !trueEnd:
			shelf_mode = true
			shelf_list.get_child(player_shelf).open()
			player.can_move = false
			if dark_mode:
				shelf_list.get_child(player_shelf).activateDarkMode(true)
		elif shelf_mode:
			shelf_mode = false
			shelf_list.get_child(player_shelf).close()
			player.can_move = true
			#shelf_list.get_child(player_shelf).activateDarkMode(false)
			
	if (player.get_game_over() || wanderer.is_game_over() || timeout) && $Cooldown.is_ready:
		if shelf_mode:
			shelf_mode = false
			shelf_list.get_child(player_shelf).close()
			player.can_move = true
		
		var total_books = $ShelfList.get_child_count() * 7
		var correct = total_books - verify_shelves()
		if correct == total_books:
			$EndTitle/ResultsLabel.modulate = Color.SEA_GREEN
		$EndTitle/ResultsLabel.text = "%d / %d sorted correctly" % [correct, total_books]
			
		if !dark_mode:
			$HUD/RoundTimerLabel.visible = false
			$Cooldown.start_timer()
			player.reset()
			wanderer.reset()
			wanderer.pause(true)
			dark_mode = true
			$CanvasModulate.visible = true
			player.game_over = false
			wanderer.set_game_over(false)
			$EndTitle.visible = true
			timeout = false
		else:
			trueEnd = true
			$EndTitle.visible = true
			player.visible = false
	
	if $EndTitle.visible && !trueEnd && $Cooldown.is_ready:
		if Input.is_anything_pressed():
			$EndTitle.visible = false
			player.activateDarkMode(true)
			wanderer.pause(false)
			
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

func _on_timer_timeout():
	timeout = true
