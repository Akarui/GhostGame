extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func is_game_over():
	var game_over = $Path2D2/PathFollow2D.game_over
	set_game_over(false)
	return game_over

func set_game_over(game_over :bool):
	$Path2D2/PathFollow2D.game_over = game_over

func reset():
	set_game_over(false)
	$Path2D2/PathFollow2D.progress_ratio = float(0)
		
func pause(pause :bool):
	$Path2D2/PathFollow2D.paused = pause
