extends Node2D

var baseEnemy = preload("res://enemies/baseEnemy/baseEnemy.tscn")

func _ready() -> void:
	var en = baseEnemy.instantiate()
	add_child(en)
	await get_tree().process_frame
	en.get_node("Sprite2D").start()
