extends Node2D

@onready var books: Node2D = $Books
@onready var cursor: Sprite2D = $Cursor

var book_scene = load("res://scenes/book.tscn")

var WIDTH = 192
var HEIGHT = 128

var loci: Array = []
var cursor_offset = Vector2(0, 100)
var workable_width = WIDTH * 0.8
var first_node = Vector2.ZERO
var cursor_index = 0
var book_selected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	#var num_books = randi_range(3,8)
	var num_books = 7
	for i in num_books:
		var book = book_scene.instantiate()
		var book_data = Global.booklist.use_rand_book()
		while book_data.title.length() > 30:
			book_data = Global.booklist.use_rand_book()
		book.customize(book_data)
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
	cursor.get_node("CanvasLayer").get_node("Label").text = "Cursor: 0"
	books.get_child(0).highlight()
	set_labels()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not book_selected:
		if Input.is_action_just_pressed("cursor_left"):
			if cursor_index > 0:
				books.get_child(cursor_index).unhighlight()
				cursor_index -= 1
				cursor.position = loci[cursor_index] + cursor_offset
				cursor.get_node("CanvasLayer").get_node("Label").text = "Cursor: " + str(cursor_index)
				books.get_child(cursor_index).highlight()
				set_labels()
			else:
				books.get_child(cursor_index).budge()
				
		if Input.is_action_just_pressed("cursor_right"):
			if cursor_index < books.get_child_count() - 1:
				books.get_child(cursor_index).unhighlight()
				cursor_index += 1
				cursor.position = loci[cursor_index] + cursor_offset
				cursor.get_node("CanvasLayer").get_node("Label").text = "Cursor: " + str(cursor_index)
				books.get_child(cursor_index).highlight()
				set_labels()
			else:
				books.get_child(cursor_index).budge()
				
		if Input.is_action_just_pressed("select_book"):
			var book = books.get_child(cursor_index)
			if book.is_lifted:
				print("ERROR: book already lifted")
				get_tree().quit()
			else:
				book.lift()
				book_selected = true
				
	else:
		if Input.is_action_just_pressed("cursor_left"):
			if cursor_index > 0:
				books.move_child(books.get_child(cursor_index), cursor_index - 1)
				cursor_index -= 1
				books.get_child(cursor_index + 1).shift_left()
				books.get_child(cursor_index).shift_right()
				cursor.position = loci[cursor_index] + cursor_offset
				cursor.get_node("CanvasLayer").get_node("Label").text = "Cursor: " + str(cursor_index)
			else:
				books.get_child(cursor_index).lifted_budge()
				
		if Input.is_action_just_pressed("cursor_right"):
			if cursor_index < books.get_child_count() - 1:
				books.move_child(books.get_child(cursor_index), cursor_index + 1)
				cursor_index += 1
				books.get_child(cursor_index - 1).shift_right()
				books.get_child(cursor_index).shift_left()
				cursor.position = loci[cursor_index] + cursor_offset
				cursor.get_node("CanvasLayer").get_node("Label").text = "Cursor: " + str(cursor_index)
			else:
				books.get_child(cursor_index).lifted_budge()
				
		if Input.is_action_just_pressed("select_book"):
			var book = books.get_child(cursor_index)
			if book.is_lifted:
				book.drop()
				book_selected = false
			else:
				print("ERROR: book already dropped")
				get_tree().quit()

		#books.get_child(cursor_index).position.y -= 10
		#books.get_child(cursor_index).modulate = Color.YELLOW
		#books.get_child(cursor_index).scale += Vector2(0.2, 0)
		#await get_tree().create_timer(.1).timeout
		#books.get_child(cursor_index).position.y += 10
		#books.get_child(cursor_index).modulate = Color.WHITE
		#books.get_child(cursor_index).scale -= Vector2(0.2, 0)

func check_shelving():
	var titles = []
	for b in books.get_children():
		titles.append(b.clean_title)
	titles.sort()
	
	var mistakes = 0
	for i in titles.size():
		if !(titles[i] == books.get_child(i).clean_title):
			print("WOMP WOMP! %s != %s" % [titles[i], books.get_child(i).clean_title])
			mistakes += 1
	
	print("total mistakes: %d" % mistakes)
	return mistakes
		
func set_labels():
	$BookTitleLabel.text = books.get_child(cursor_index).title
	$BookAuthorLabel.text = books.get_child(cursor_index).author_name
	$BookPubLabel.text = books.get_child(cursor_index).pub_year

func get_loci():
	return loci


