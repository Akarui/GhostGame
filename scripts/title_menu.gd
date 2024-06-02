extends Control

var game_scene = preload("res://scenes/root.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_pressed():
	get_tree().change_scene_to_packed(game_scene)


func _on_quit_button_pressed():
	get_tree().quit()
