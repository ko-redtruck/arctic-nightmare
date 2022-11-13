extends KinematicBody2D

var WALK_SPEED = 2500
var GRAVITY = 1900
var JUMP_SPEED = 900
var MAX_WALK_SPEED = 500
var FRICTION = 3200
var LADDER_SPEED = 500

var velocity = Vector2()
var was_walljump_used = false
var is_facing_right = true
var is_on_ladder = false
var is_jumping = false
var current_idle_animation = "idle"
var _gravity = GRAVITY

func _ready():
	pass # Replace with function body.

func drop_equipped_item():
	var current_item = get_equipped_item()
	current_item.on_drop(self)
	$ItemHolder.remove_child(current_item)
	current_item.get_node("CollisionShape2D").disabled = false
	current_item.set_mode(RigidBody2D.MODE_RIGID)
	current_item.sleeping = false
	current_item.position = self.position + $ItemHolder.position
	self.get_parent().add_child(current_item)

func has_equipped_usable_item():
	return self.has_equipped_item() and self.get_equipped_item().is_usable()

func has_equipped_item():
	return self.get_equipped_item() != null

func can_equip_item_from_world():
	return self.get_nearest_item_in_world() != null

func use_equipped_item():
	return self.get_equipped_item().use_on(self)

func equip(item):
	if self.has_equipped_item():
		self.drop_equipped_item()

	print("Equipping ",item, item.get_node("CollisionShape2D"))
	item.get_node("CollisionShape2D").disabled = true
	item.set_mode(RigidBody2D.MODE_STATIC)

	item.position = Vector2(0, 0)
	$ItemHolder.add_child(item)

func kill():
	print("Player died")
	GameState.player_killed()

func get_equipped_item():
	if $ItemHolder.get_child_count() < 1:
		return null
	else:
		return $ItemHolder.get_child(0)

func get_nearest_item_in_world():
	var distance_to_nearest_item = INF
	var nearest_item = null
	var current_item = self.get_equipped_item()
	for node in $PickUpArea.get_overlapping_bodies():
			if node.is_in_group("Items") and node != current_item:
				var distance_to_item = node.position.distance_to(self.position)
				if distance_to_item < distance_to_nearest_item:
					nearest_item = node
					distance_to_nearest_item = distance_to_item
	return nearest_item

func _physics_process(delta):

	var walk_force = WALK_SPEED * (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	if abs(walk_force) < 0.2 * WALK_SPEED:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
	else:
		velocity.x = clamp(velocity.x  + walk_force * delta, -MAX_WALK_SPEED, MAX_WALK_SPEED)
	velocity.y += _gravity * delta
	#Vecotor2(0, -1) is telling Godot the up direction

	#animation stuff
	if walk_force < 0:
		is_facing_right = false
		if is_jumping:
			$AnimationPlayer.play("jump_left")
		else:
			$AnimationPlayer.play("walk_left")
	elif walk_force > 0:
		is_facing_right = true
		if is_jumping:
			$AnimationPlayer.play("jump_right")
		else:
			$AnimationPlayer.play("walk_right")
	elif walk_force == 0:
		if is_jumping && is_facing_right:
			$AnimationPlayer.play("jump_right")
		elif is_jumping && !is_facing_right:
			$AnimationPlayer.play("jump_left")
		else:
			$AnimationPlayer.play(current_idle_animation)

	if is_on_ladder:
		_gravity = 0
		velocity.y += Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		velocity.y *= .9
	else:
		_gravity = GRAVITY

	move_and_slide(velocity, Vector2(0, -1))

	if is_on_floor() or is_on_ladder:
		was_walljump_used = false
		is_jumping = false
	if is_on_floor() or is_on_ceiling():
		velocity.y = 0
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			is_jumping = true
			velocity.y = -JUMP_SPEED
		elif is_on_wall() and was_walljump_used == false:
			was_walljump_used = true
			velocity.y = -JUMP_SPEED
			velocity.x += clamp(-velocity.x * MAX_WALK_SPEED * 20, -MAX_WALK_SPEED * 5, MAX_WALK_SPEED * 5)
		elif is_on_ladder:
			velocity.y = -LADDER_SPEED
	if Input.is_action_just_pressed("ui_pick_up_or_drop"):
		var item = get_nearest_item_in_world()
		if item != null:
			item.pick_up_on(self)
		elif self.has_equipped_item():
			self.drop_equipped_item()
	if Input.is_action_just_pressed("ui_use"):
		if self.has_equipped_item():
			self.use_equipped_item()


func _on_LadderArea_area_entered(area):
	is_on_ladder = true
	if velocity.y > 0:
		velocity.y = 0

func _on_LadderArea_area_exited(area):
	is_on_ladder = false
