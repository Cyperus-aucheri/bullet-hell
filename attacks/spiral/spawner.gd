extends Control

var currentAngle: float = 0
var screenSize: Vector2

var screen_left: int;
var screen_width: int;

func SpawnBullet(pos: Vector2):
	var scene = load("res://bullets/baseBullet.tscn")
	var instance = scene.instantiate()
	add_child(instance)
	
	var direction = Vector2(cos(deg_to_rad(currentAngle)), sin(deg_to_rad(currentAngle)))
	# Set velocity to have a magnitude of 10
	var velocity = direction.normalized() * 5
	
	var bullet = instance.get_node("Bullet")
	
	bullet.velocity = velocity
	bullet.position = pos
	bullet.rotation = deg_to_rad(currentAngle)
	bullet.screen_left = screen_left
	bullet.screen_width = screen_width
	
	currentAngle += 10
	
	await get_tree().create_timer(0.15).timeout	

# Called when the node enters the scene tree for the first time.
func start(pos: Vector2) -> void:
	screenSize = get_viewport_rect().size
	
	for i in range(50):
		SpawnBullet(pos)
		SpawnBullet(pos)
		await SpawnBullet(pos)
