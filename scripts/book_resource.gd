extends Resource
class_name BookResource

@export var title: String = ""
@export var author_birth: String = ""
@export var author_death: String = ""
@export var author_name: String = ""
@export var pub_year: String = ""
@export var num_chars: String = ""
@export var num_words: String = ""

func customize(data):
	title = str(data["title"]) if data.has("title") else ""
	author_birth = str(data["author_birth"]) if data.has("author_birth") else ""
	author_death = str(data["author_death"]) if data.has("author_death") else ""
	author_name = str(data["author_name"]) if data.has("author_name") else ""
	pub_year = str(data["pub_year"]) if data.has("pub_year") else ""
	num_chars = str(data["num_chars"]) if data.has("num_chars") else ""
	num_words = str(data["num_words"]) if data.has("num_words") else ""

func _to_string():
	var string = "title: " + title
	string += "\nauthor_birth: " + author_birth
	string += "\nauthor_death: " + author_death
	string += "\nauthor_name: " + author_name
	string += "\npub_year: " + pub_year
	string += "\nnum_chars: " + num_chars
	string += "\nnum_words: " + num_words
	return string
