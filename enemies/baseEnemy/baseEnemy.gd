extends Sprite2D

var attacks = {
	"holeInWall": load("res://attacks/holeInTheWall/holeInTheWall.tscn"),
	"rain": load("res://attacks/rain/rainAttack.tscn"),
	"spiral": load("res://attacks/spiral/spiralAttack.tscn")
}

var enemies = [
	preload("res://enemies/sprites/BlueEnemySprite1.png"),
	preload("res://enemies/sprites/PurpleEnemySprite1.png"),
	preload("res://enemies/sprites/RedEnemySprite1.png")
]

var attackNames = ["holeInWall", "rain", "spiral"]

var rng = RandomNumberGenerator.new()
var screen_width: int
var screen_left: int

signal enemy_hit(new_health)

const maxHealth = 200
var health: int = maxHealth  # Global score variable

func take_hit():
	health = clamp(health - 5, 0, maxHealth)
	emit_signal("enemy_hit", health, maxHealth)
	
	if health <= 0:
		get_parent().queue_free()
	
	print("Enemy hit:", health) 

func spawnAttack(atkName: String):
	var atk = attacks[atkName]
	
	if (!atk):
		print(atkName + " not found in attacks list")
		return
	
	var instance = atk.instantiate()
	
	add_child(instance)
	
	var spawner = instance.get_node("Spawner")
	
	spawner.screen_left = screen_left
	spawner.screen_width = screen_width
	
	await spawner.start(Vector2(0, 0))
	
func start():
	texture = enemies.pick_random()
	
	screen_left = get_node("../../../Gameui/StaticBody2D/GameRectangle").global_position.x
	screen_width = get_node("../../../Gameui/StaticBody2D/GameRectangle").texture.get_size().x
	
	position = Vector2(rng.randi_range(screen_left + 25, screen_left + screen_width - 25), -100)
	
	var tween = get_tree().create_tween()
	await tween.tween_property(self, "position", position + Vector2(0, rng.randi_range(150, 300)), 0.5)
	
	while true:
		await spawnAttack(attackNames.pick_random())


func _on_area_2d_area_entered(area: Area2D) -> void:
	print("Hit by:", area.name)  # Debug
	if area.name == "WitchBullet":
		Global.hit_boss()
		
		area.get_parent().queue_free()  # Destroy bullet
		
		if Global.bossHealth <= 0:
			get_parent().queue_free()
