extends Node2D

#@onready var shelf_viewport: SubViewport = $BookShelfCanvasLayer/SubViewportContainer/SubViewport
#@onready var shelf: Node2D = $BookShelfCanvasLayer/SubViewportContainer/SubViewport/Shelf
@onready var shelf: Node2D = $Shelf
@onready var wanderer: Node2D = $CanvasGroup/Wanderer
@onready var player: Node2D = $CanvasGroup/Player

var shelf_scene = load("res://scenes/shelf.tscn")
var wanderer_scene = load("res://scenes/wanderer.tscn")
var player_scene = load("res://scenes/player.tscn")

var shelf_mode = false
var dark_mode = false
var isPaused = false
var trueEnd = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasModulate.visible = false
	$EndTitle.visible = false
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("open_shelf"):
		if not shelf_mode:
			shelf_mode = true
			shelf.open()
			player.can_move = false
			if dark_mode:
				shelf.activateDarkMode()
			
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
	
			
		
		#if shelf_viewport.get_child_count() > 0:
			#shelf_viewport.get_child(0).check_shelving()
			#shelf_viewport.get_child(0).queue_free()
			#$BookShelfCanvasLayer.visible = false
		#else:
			#var shelf_instance = shelf_scene.instantiate()
			#shelf_viewport.add_child(shelf_instance)
			#$BookShelfCanvasLayer.visible = true
			
