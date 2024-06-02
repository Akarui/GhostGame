extends Node2D

var is_ready: bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func start_timer():
	is_ready = false
	$Timer.start()
	
func _on_timer_timeout():
	is_ready = true
