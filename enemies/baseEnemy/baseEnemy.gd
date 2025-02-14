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

func spawnAttack(atkName: String):
	var atk = attacks[atkName]
	
	if (!atk):
		print(atkName + " not found in attacks list")
		return
	
	var instance = atk.instantiate()
	
	add_child(instance)
	
	var spawner = instance.get_node("Spawner")
	
	spawner.screen_left = get_node("../../../Gameui/StaticBody2D/GameRectangle").global_position.x
	spawner.screen_width = get_node("../../../Gameui/StaticBody2D/GameRectangle").texture.get_size().x
	
	await spawner.start(position + texture.get_size() / 2)
	
func _ready():
	texture = enemies.pick_random()
	
	while true:
		await spawnAttack(attackNames.pick_random())
