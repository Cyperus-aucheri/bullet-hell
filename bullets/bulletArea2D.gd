extends Area2D

func _process(delta):
	for body in get_overlapping_bodies():
		if (body.name == "CharacterBody2D"):
			Global.take_hit()
			get_parent().queue_free()  # Destroy bullet
