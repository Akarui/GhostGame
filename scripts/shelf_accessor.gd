extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if area.name == "ShelfAccessCollider":
		get_parent().get_parent().set_player_shelf(get_index())


func _on_area_exited(area):
	if area.name == "ShelfAccessCollider":
		if get_parent().get_parent().player_shelf == get_index():
			get_parent().get_parent().set_player_shelf(-1)
