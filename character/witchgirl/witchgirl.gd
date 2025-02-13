extends CharacterBody2D

var SPEED = 300
var SLOW_SPEED = 100

var input_direction = Vector2.ZERO  
var can_shoot = true
@onready var sprite = $Sprite
@onready var hitbox = $Hitbox  
@export var shoot_cooldown = 0.5

func _ready():
	hitbox.visible = false  

func _physics_process(_delta):
	input_direction = get_input_direction()

	var current_speed = SPEED
	if Input.is_action_pressed("ui_focus"):
		current_speed = SLOW_SPEED
		hitbox.visible = true  
	else:
		hitbox.visible = false  

	velocity = input_direction * current_speed
	move_and_slide()

	# Flip the sprite based on the direction of movement
	if input_direction.x < 0:
		sprite.flip_h = true  # Flip sprite when moving left
	elif input_direction.x > 0:
		sprite.flip_h = false  # Face right when moving right

func get_input_direction():
	var x = -int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right"))
	var y = -int(Input.is_action_pressed("ui_up")) + int(Input.is_action_pressed("ui_down"))
	
	var direction = Vector2(x, y)
	
	if direction.length() > 0:  # Only normalize if there's movement
		return direction.normalized()
	
	return Vector2.ZERO

func shoot_bullets():
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shoot()
		can_shoot = false
		await get_tree().create_timer(shoot_cooldown).timeout
		can_shoot = true
		
func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.position = $Position2D.global_position  # Spawns at the Position2D node
	get_tree().root.add_child(bullet)
