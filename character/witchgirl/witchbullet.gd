extends Area2D

@export var speed = 800  # Speed of the bullet
var velocity: Vector2 = Vector2.ZERO

func _ready():
	# Use Callable instead of a string for connecting the signal
	self.body_entered.connect(_on_body_entered)

func _process(delta):
	velocity.x = speed * delta
	position += velocity * delta
	if position.x > get_viewport_rect().size.x:  # Off screen
		queue_free()  # Delete the bullet

func _on_body_entered(body):
	queue_free()  # Delete the bullet on collision
