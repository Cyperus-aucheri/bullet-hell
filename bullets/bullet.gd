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
var screen_size: Vector2

func _ready() -> void:
	screen_size = get_viewport_rect().size  # Get the viewport size

func ColorBullet(col: String):
	currentBullet = col
	bulletSprite = "res://placeholders/Sprites/Lasers/" + BulletCols[currentBullet] + ".png"
	texture = load(bulletSprite)


func _process(delta: float) -> void:
	position += velocity.normalized() * 200 * delta  # Move bullet

	# Remove if bullet is out of bounds
	if position.x < 0 or position.x > screen_size.x or position.y < 0 or position.y > screen_size.y:
		queue_free()  # Remove the bullet from the scene
