extends KinematicBody2D

export (int) var WALK_SPEED = 100
export (int) var GRAVITY = 300
export (int) var JUMP_SPEED = 300
export (int) var MAX_WALK_SPEED = 600
export (int) var FRICTION = 200

var velocity = Vector2()

func _ready():
	pass # Replace with function body.

func drop_equipped_item():
	var current_item = get_equipped_item()
	$ItemHolder.remove_child(current_item)
	current_item.get_node("CollisionShape2D").disabled = false
	current_item.set_mode(RigidBody2D.MODE_RIGID)
	current_item.position = self.position + $ItemHolder.position
	self.get_parent().add_child(current_item)

func has_equipped_item():
	return self.get_equipped_item() != null

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
		
	if Input.is_action_just_pressed("ui_pick_up_or_drop"):
		var item = get_nearest_item_in_world()
		if item != null:
			item.pick_up_on(self)
		elif self.has_equipped_item():
			self.drop_equipped_item()
	
	if Input.is_action_just_pressed("ui_use"):
		if self.has_equipped_item():
			self.use_equipped_item()
			
