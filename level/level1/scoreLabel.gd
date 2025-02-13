extends Label

func _ready():
	Global.connect("health_changed", Callable(self, "_on_health_changed"))

func _on_health_changed(new_health):
	text = "Health: " + str(new_health)
	print("Health asd: ", str(new_health))
