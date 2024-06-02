extends Resource
class_name BookListResource

var file = "res://bookdata/classics.json"
var booklist = []
var used = []

func initialize():
	var booklist_json = JSON.parse_string(FileAccess.get_file_as_string(file))
	for book_data in booklist_json:
		var book = BookResource.new()
		book.customize(book_data)
		booklist.append(book)
	#print("BOOKLIST: " + str(booklist.size()))
	#print(booklist[randi() % booklist.size()])

func get_book(index):
	return booklist[index]

func use_rand_book():
	var index = randi() % booklist.size()
	while used.has(index):
		index = randi() % booklist.size()
	used.append(index)
	return booklist[index]
