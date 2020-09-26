extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var worldDirection = Vector3(0, 1, 0)
var direction = Vector3(0,0,0);
var velocity = Vector3()

var speed = 600;
var jump_speed = 10;
var gravity = -9.8
var air_resistance = -20;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	direction = Vector3(0,0,0);
	
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
		
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
		
	if Input.is_action_pressed("ui_down"):
		direction.z += 1
		
	if Input.is_action_pressed("ui_up"):
		direction.z -= 1
		
	direction = direction.normalized()
	direction = direction * speed * delta
	
	var multiplier = air_resistance if velocity.y > 0 else gravity
	velocity.y += multiplier * delta
	velocity.x = direction.x
	velocity.z = direction.z
	
	velocity = move_and_slide(velocity, worldDirection);
	
	if is_on_floor() and Input.is_key_pressed(KEY_SPACE):
		velocity.y = jump_speed


