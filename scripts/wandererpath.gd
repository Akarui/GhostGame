extends PathFollow2D

var speed = 0.09
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress_ratio += delta * speed


signal spotted

func _on_body_entered(body):
	print(body, " entered")

func _on_area_2d_body_entered(body):
	print(body, " entered") # Replace with function body.

