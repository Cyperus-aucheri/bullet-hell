extends ColorRect

var attacks = {
	"holeInWall": load("res://attacks/holeInTheWall/holeInTheWall.tscn"),
	"rain": load("res://attacks/rain/rainAttack.tscn"),
	"spiral": load("res://attacks/spiral/spiralAttack.tscn")
}

const attacksNames = ["holeInWall", "rain", "spiral"]

func spawnAttack(atkName: String):
	var atk = attacks[atkName]
	
	if (!atk):
		print(atkName + " not found in attacks list")
		return
	
	var instance = atk.instantiate()
	
	add_child(instance)
	
	var spawner = instance.get_node("Spawner")
	
	spawner.screen_left = get_node("../../Gameui/StaticBody2D/GameRectangle").global_position.x
	spawner.screen_width = get_node("../../Gameui/StaticBody2D/GameRectangle").texture.get_size().x
	
	await spawner.start(position + get_size() / 2)
	
func _ready():
	while true:
		await spawnAttack(attacksNames.pick_random())
