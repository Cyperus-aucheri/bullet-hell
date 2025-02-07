extends Control

# [{"bullet": bullet, "velocity": velocity}]
var bullets = []

var bulletsToRemove = []

var currentAngle: float = 0
var screenSize: Vector2

func SpawnBullet():
	var scene = load("res://bullets/templateBullet.tscn")
	var instance = scene.instantiate()
	
	add_child(instance)
	
	var direction = Vector2(cos(deg_to_rad(currentAngle)), sin(deg_to_rad(currentAngle)))
	# Set velocity to have a magnitude of 10
	var velocity = direction.normalized() * 10
	
	bullets.append({"bullet": instance, "velocity": velocity})
	
	currentAngle += 5
	
	await get_tree().create_timer(0.15).timeout	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screenSize = get_viewport_rect().size
	
	for i in range(10000):
		SpawnBullet()
		SpawnBullet()
		SpawnBullet()
		await SpawnBullet()
		
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	for b in bullets:
		var bullet = b["bullet"]
		bullet.position += b["velocity"]
		
		if bullet.position > screenSize or bullet.position < Vector2.ZERO:
			bulletsToRemove.append(b)
			
	for b in bulletsToRemove:
		var bullet = b["bullet"]
		remove_child(bullet)
		bullets.remove_at(bullets.find(b))
		
	bulletsToRemove.clear()
