extends Node

signal health_changed(new_health)
signal boss_health_changed(new_health, max_health)

const maxHealth = 5
var health: int = maxHealth  # Global score variable

const bossMaxHealth = 200
var bossHealth: int = bossMaxHealth

func restart():
	health = maxHealth
	bossHealth = bossMaxHealth

func take_hit():
	health = clamp(health - 1, 0, maxHealth)
	emit_signal("health_changed", health)
	print("Health:", health)  # Debugging

func hit_boss():
	
	bossHealth = clamp(bossHealth - 1, 0, bossMaxHealth)
	emit_signal("boss_health_changed", bossHealth, bossMaxHealth)
	print("Boss Health:", bossHealth)  # Debugging
