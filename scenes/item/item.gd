extends TextureRect


var revealed = false


func add_icon(item) -> void:
	texture = item["icon"]
