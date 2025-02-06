extends ColorRect

@export var remaining = 50
@export var total = 100

func _ready() -> void:
	$Green.position = $Red.position
	$Green.size = $Red.size

func _process(_delta: float) -> void:
	$Green.scale = Vector2(float(remaining) / float(total), 1)
