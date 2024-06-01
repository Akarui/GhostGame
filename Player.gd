extends Area2D

@export var speed = 200
@export var PLAYER_START_X = 100
@export var PLAYER_START_Y = 100;
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	# So we can decide player start point
	position = Vector2(PLAYER_START_X, PLAYER_START_Y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	
	# Clamp can be adjusted as needed for sprite
	position = position.clamp(Vector2(15,15), Vector2(screen_size.x - 15, screen_size.y - 15))
		
		
signal spotted

func _on_body_entered(body):
	print(body, " entered")
