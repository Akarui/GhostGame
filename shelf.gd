extends Node2D

@onready var books: Node2D = $Books
@onready var cursor: Sprite2D = $Cursor

var book_scene = preload("res://book.tscn")

var WIDTH = 250
var HEIGHT = 180

var loci: Array = []
var cursor_offset = Vector2(0, 100)
var workable_width = WIDTH * 0.8
var first_node = Vector2.ZERO
var cursor_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var num_books = randi_range(3,8)
	for i in num_books:
		var book = book_scene.instantiate()
		book.cover_color = Color(randf(), randf(), randf(), 1)
		books.add_child(book)
	
	var gap = workable_width / (books.get_child_count() - 1)
	first_node.x = -(workable_width / 2)
	
	for i in books.get_child_count():
		var locus = Vector2.ZERO
		locus.x = first_node.x + (gap * i)
		loci.append(locus)
		
	for i in books.get_child_count():
		books.get_child(i).position = loci[i]
	
	cursor.position = loci[0] + cursor_offset
	books.get_child(0).highlight()
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_left"):
		if cursor_index > 0:
			books.get_child(cursor_index).unhighlight()
			cursor_index -= 1
			cursor.position = loci[cursor_index] + cursor_offset
			books.get_child(cursor_index).highlight()
			
	if Input.is_action_just_pressed("ui_right"):
		if cursor_index < books.get_child_count() - 1:
			books.get_child(cursor_index).unhighlight()
			cursor_index += 1
			cursor.position = loci[cursor_index] + cursor_offset
			books.get_child(cursor_index).highlight()
		#
	#if Input.is_action_just_pressed("ui_accept"):
		#var num = randi() % books.get_child_count()
		#cursor.position = loci[num] + cursor_offset
		#
		#books.get_child(num).highlight()
		#await get_tree().create_timer(1).timeout
		#books.get_child(num).unhighlight()


