extends PathFollow2D

var speed = 0.05
var previous_position = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	previous_position = Vector2(position.x, position.y)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress_ratio += delta * speed
	var deltaX = position.x - previous_position.x
	var deltaY = position.y - previous_position.y
	var newVelocity = Vector2(deltaX, deltaY).normalized()
	var newTarget = Vector2(newVelocity.x * 50, newVelocity.y * 50)
	$Area2D/MidVisionCast.set_target_position(newTarget)
	previous_position = position
	
	if $Area2D/MidVisionCast.is_colliding() && $Area2D/MidVisionCast.get_collider().is_in_group("player"):
		print("Game Over")
		
	if (deltaX > 0) && (abs(deltaY) < abs(deltaX)):
		$Area2D/AnimatedSprite2D.play("var1_walk_right")
	if (deltaX < 0) && (abs(deltaY) < abs(deltaX)):
		$Area2D/AnimatedSprite2D.play("var1_walk_left")
	if (deltaY < 0) && (abs(deltaY) > abs(deltaX)):
		$Area2D/AnimatedSprite2D.play("var1_walk_up")
	if (deltaY > 0) && (abs(deltaY) > abs(deltaX)):
		$Area2D/AnimatedSprite2D.play("var1_walk_down")
