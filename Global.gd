extends Node

signal health_changed(new_health)

const maxHealth = 5
var health: int = maxHealth  # Global score variable

func _ready() -> void:
	emit_signal("health_changed", health)

func take_hit():
	health = clamp(health - 1, 0, maxHealth)
	emit_signal("health_changed", health)
	print("Health:", health)  # Debugging
