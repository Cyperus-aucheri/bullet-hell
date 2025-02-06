extends CharacterBody2D

var SPEED = 300
var SLOW_SPEED = 100

var input_direction = Vector2.ZERO  

@onready var sprite = $Sprite
@onready var hitbox = $Hitbox  

func _ready():
	hitbox.visible = false  

func _physics_process(_delta):
	input_direction = get_input_direction()
	print("Input Direction:", input_direction)  # Debug

	var current_speed = SPEED
	if Input.is_action_pressed("ui_focus"):
		current_speed = SLOW_SPEED
		hitbox.visible = true  
	else:
		hitbox.visible = false  

	velocity = input_direction * current_speed
	move_and_slide()

func get_input_direction():
	var x = -int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right"))
	var y = -int(Input.is_action_pressed("ui_up")) + int(Input.is_action_pressed("ui_down"))
	
	var direction = Vector2(x, y)
	
	if direction.length() > 0:  # Only normalize if there's movement
		return direction.normalized()
	
	return Vector2.ZERO
