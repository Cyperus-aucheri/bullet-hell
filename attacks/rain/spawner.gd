extends Control

var screenSize: Vector2

@export var screen_width = 100
@export var screen_left = 0
var rng = RandomNumberGenerator.new()

func SpawnBullet(spawnPos: Vector2):
	var scene = load("res://bullets/baseBullet.tscn")
	var instance = scene.instantiate()
	add_child(instance)
	
	var direction = Vector2(0, 1)
	# Set velocity to have a magnitude of 10
	var velocity = direction.normalized() * 5
	
	var bullet = instance.get_node("Bullet")
	
	bullet.velocity = velocity
	bullet.global_position = spawnPos
	bullet.rotation = PI / 2
	bullet.screen_left = screen_left
	bullet.screen_width = screen_width
	
	await get_tree().create_timer(0.15).timeout	

# Called when the node enters the scene tree for the first time.
func start(_pos: Vector2) -> void:
	for i in range(50):
		await SpawnBullet(Vector2(rng.randi_range(screen_left, screen_left + screen_width), 0))
