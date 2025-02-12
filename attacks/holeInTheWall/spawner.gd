extends Control

var screenSize: Vector2
var rot: int = 90

const colors = ["Blue", "Red", "Green", "Purple"]

var screen_left: int
var screen_width: int
var scene = load("res://bullets/baseBullet.tscn")

var rng = RandomNumberGenerator.new()

func SpawnBullet(spawnPos: Vector2, col: String, currentAngle: float):
	var instance = scene.instantiate()
	add_child(instance)
	
	var direction = Vector2(cos(deg_to_rad(currentAngle + rot)), sin(deg_to_rad(currentAngle + rot)))
	# Set velocity to have a magnitude of 10
	var velocity = direction.normalized() * 5
	
	var bullet = instance.get_node("Bullet")
	
	bullet.ColorBullet(col)
	bullet.rotation = deg_to_rad(currentAngle + rot)
	bullet.velocity = velocity
	bullet.position = spawnPos
	bullet.screen_left = screen_left
	bullet.screen_width = screen_width
	
# Called when the node enters the scene tree for the first time.
func start(pos: Vector2) -> void:
	for x in range(4):
		var currentAngle: float = 0
		var col = colors.pick_random()
		for i in range(45):
			await SpawnBullet(pos, col, currentAngle)
			currentAngle += 7
		rot = rng.randf_range(25, 175)
		await get_tree().create_timer(0.75).timeout
