extends CanvasLayer

export (Color) var DEACTIVATED_MODULATION_COLOR = "#69ffffff"
export (Color) var ACTIVATED_MODULATION_COLOR = "#ffffff"

func _ready():
	self.deactivate_item_pick_up()
	self.deactivate_item_usable()
	
func set_timer(timer_time):
	$Timer.text = timer_time

func deactivate_item_usable():
	$ItemUsable.modulate = DEACTIVATED_MODULATION_COLOR

func deactivate_item_pick_up():
	$ItemPickUp.modulate = DEACTIVATED_MODULATION_COLOR

func activate_item_usable():
	$ItemUsable.modulate = ACTIVATED_MODULATION_COLOR

func activate_item_pick_up():
	$ItemPickUp.modulate = ACTIVATED_MODULATION_COLOR

func _process(delta):
	$Timer.text = str(int(get_parent().get_node("StormCountdown").time_left))
	if get_parent().get_node("Player2D").has_equipped_usable_item():
		self.activate_item_usable()
	else:
		self.deactivate_item_usable()
		
	if get_parent().get_node("Player2D").can_equip_item_from_world():
		self.activate_item_pick_up()
	else:
		self.deactivate_item_pick_up()
		
	
