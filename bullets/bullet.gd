extends Sprite2D

@export var velocity = Vector2(0, 0)

const BulletCols = {
	"Blue": "01",
	"Red": "02",
	"Purple": "04",
	"Green":  "09"
}

const baseBullet = "01"
var currentBullet = "Blue"

var bulletSprite = "://res/placeholders/Sprites/Lasers/" + BulletCols[currentBullet] or baseBullet + ".png"

# Get screen size
var screen_width: int
var screen_left: int

func ColorBullet(col: String):
	currentBullet = col
	bulletSprite = "res://placeholders/Sprites/Lasers/" + BulletCols[currentBullet] + ".png"
	texture = load(bulletSprite)


func _process(delta: float) -> void:
	position += velocity.normalized() * 200 * delta  # Move bullet

	# Remove if bullet is out of bounds
	if global_position.x < screen_left or global_position.x > screen_left + screen_width:
		queue_free()  # Remove the bullet from the scene
