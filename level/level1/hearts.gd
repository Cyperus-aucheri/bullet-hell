extends Node2D

const MAX_HEALTH = 5
const RED_HEART = "res://placeholders/Hearts/red.png"
const GRAY_HEART = "res://placeholders/Hearts/gray.png"

var health: int = MAX_HEALTH

func _ready():
	Global.health_changed.connect(_on_set_health)
	update_hearts()

func _on_set_health(value: int):
	health = clamp(value, 0, MAX_HEALTH)
	update_hearts()

func update_hearts():
	# Clear existing hearts	
	for child in get_children():
		child.queue_free()

	# Add new hearts based on current health
	for i in range(MAX_HEALTH):
		var heart = TextureRect.new()
		heart.texture = load(RED_HEART if i < health else GRAY_HEART)
		heart.scale = Vector2(0.1, 0.1)
		heart.custom_minimum_size  = Vector2(32, 32) # Adjust size if needed
		heart.position = Vector2(i * 48, 0) # Adjust spacing if needed
		add_child(heart)
	
	if health <= 0:
		get_tree().change_scene_to_file("res://gameover.tscn")
