extends KinematicBody2D

export (int) var WALK_SPEED = 100
export (int) var GRAVITY = 300
export (int) var JUMP_SPEED = 300
export (int) var MAX_WALK_SPEED = 600
export (int) var FRICTION = 200

var velocity = Vector2()

func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var walk_force = WALK_SPEED * (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	if abs(walk_force) < 0.2 * WALK_SPEED:
		velocity.x = move_toward(walk_force, 0, FRICTION * delta)
	else:
		velocity.x += walk_force
		
	velocity.x = clamp(velocity.x, -MAX_WALK_SPEED, MAX_WALK_SPEED)
	velocity.y += GRAVITY * delta
	#Vecotor2(0, -1) is telling Godot the up direction
	move_and_slide(velocity, Vector2(0, -1))

	if is_on_floor():
		velocity.y = 0
	if (is_on_floor() or is_on_wall()) and Input.is_action_just_pressed("ui_up"):
		velocity.y = -JUMP_SPEED
		
	if Input.is_action_just_pressed("ui_pickup"):
		for node in $PickupArea.get_overlapping_bodies():
			if node.is_in_group("Items"):
				print(node)

