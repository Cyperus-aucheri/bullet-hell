extends Button

func _pressed() -> void:
	Global.restart()
	get_tree().change_scene_to_file("res://level/level1/level1.tscn")
