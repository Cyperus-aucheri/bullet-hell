extends ColorRect

@export var total = 100

var remaining: float = 100:
	set(value):
		remaining = clamp(value, 0, total)
		$Green.scale = Vector2(remaining / float(total), 1)

func _ready() -> void:
	$Green.position = $Red.position
	$Green.size = $Red.size
	$Green.scale = Vector2(remaining / float(total), 1)
