extends Area2D

@export var speed = 200
@export var PLAYER_START_X = 100
@export var PLAYER_START_Y = 100;
var screen_size
var can_move

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	modulate.a8 = 98
	can_move = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_move:
		var velocity = Vector2.ZERO # The player's movement vector.
		if Input.is_action_pressed("move_right"):
			velocity.x += 1
			velocity.y = 0
		if Input.is_action_pressed("move_left"):
			velocity.x -= 1
			velocity.y = 0
		if Input.is_action_pressed("move_down"):
			velocity.y += 1
			velocity.x = 0
		if Input.is_action_pressed("move_up"):
			velocity.y -= 1
			velocity.x = 0
		
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
			if (velocity.x > 0):
				$AnimatedSprite2D.play("walk_right")
			if (velocity.x < 0):
				$AnimatedSprite2D.play("walk_left")
			if (velocity.y < 0):
				$AnimatedSprite2D.play("walk_up")
			if (velocity.y > 0):
				$AnimatedSprite2D.play("walk_down")
		else:
			$AnimatedSprite2D.play("idle")
			
		position += velocity * delta
		
		# Clamp can be adjusted as needed for sprite
		position = position.clamp(Vector2(15,15), Vector2(screen_size.x - 15, screen_size.y - 15))
	else:
		pass


func _on_area_entered(area):
	if area.is_in_group("enemy"):
		print(area, "Game Over") # Replace with function body.

