extends Control

var currentAngle: float = 0
var screenSize: Vector2
var spawnPos: Vector2 = Vector2(100, 100)

func SpawnBullet():
	var scene = load("res://bullets/baseBullet.tscn")
	var instance = scene.instantiate()
	add_child(instance)
	
	var direction = Vector2(cos(deg_to_rad(currentAngle)), sin(deg_to_rad(currentAngle)))
	# Set velocity to have a magnitude of 10
	var velocity = direction.normalized() * 5
	
	var bullet = instance.get_node("Bullet")
	
	bullet.velocity = velocity
	bullet.position = spawnPos
	
	currentAngle += 10
	
	await get_tree().create_timer(0.15).timeout	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screenSize = get_viewport_rect().size
	
	for i in range(50):
		SpawnBullet()
		SpawnBullet()
		await SpawnBullet()
