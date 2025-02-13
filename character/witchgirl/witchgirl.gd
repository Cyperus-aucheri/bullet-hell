extends CharacterBody2D

var SPEED = 300
var SLOW_SPEED = 100
@export var bullet_scene = preload("res://character/witchgirl/witchbullet.tscn")
@export var shoot_cooldown = 0.2  # Time between shots
var can_shoot = true

var input_direction = Vector2.ZERO  
@onready var sprite = $Sprite
@onready var hitbox = $Hitbox  
@onready var bullet_spawn = $Position2D  # Position2D for spawning bullets

func _ready():
	hitbox.visible = false  
	# Confirm bullet scene loads correctly
	var test_bullet = bullet_scene.instantiate()
	if test_bullet == null:
		print("Bullet scene failed to load.")
	else:
		print("Bullet scene loaded successfully.")
		
func _process(delta):
	_shoot_bullets(delta)
	
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

func _shoot_bullets(_delta):
	if Input.is_action_pressed("shoot") and can_shoot:
		print("Shoot button pressed and can shoot")
		shoot()
		can_shoot = false
		await get_tree().create_timer(shoot_cooldown).timeout
		can_shoot = true
		
func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.position = bullet_spawn.global_position  # Spawns at the Position2D node
	bullet.velocity = Vector2(0, -400)  # Shoots up
	get_parent().add_child(bullet)  # Adds bullet to the same layer as the character
