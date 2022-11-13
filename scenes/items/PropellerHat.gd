extends "res://scenes/items/Item.gd"

var propeller_texture = preload("res://assets/characters/scientist_animation_propeller.png")
var normal_texture = preload("res://assets/characters/scientist_animation.png")

export (bool) var CAN_FLY = false


export (float) var FLY_FORCE = 50
var cooldown_over = true
var current_player = null

func _ready():
	item_name = "propeller_hat"
	
	if GameState.is_in_random_sleep_state():
		CAN_FLY = true

func on_drop(player):
	.on_drop(player)
	player.get_node("Sprite").set_texture(normal_texture)
	$Sprite.show()
	
func pick_up_on(player):
	.pick_up_on(player)
	player.get_node("Sprite").set_texture(propeller_texture)
	$Sprite.hide()

func use_on(player):
	if self.is_usable():
		current_player = player
		$CooldownTimer.start()
		cooldown_over = false
		$Sprite.position = Vector2(-18, -32)
		rotation_degrees = 0

func _physics_process(delta):
	if current_player == null:
		return
	current_player.velocity.y -= FLY_FORCE

func is_usable():
	print("is_usable ", cooldown_over, CAN_FLY)
	return cooldown_over and self.CAN_FLY

func _on_CooldownTimer_timeout():
	if current_player != null:
		current_player = null
		$Sprite.position = Vector2()
		$CooldownTimer.start()
	else:
		cooldown_over = true
	
