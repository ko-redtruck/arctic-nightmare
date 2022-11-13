extends CanvasLayer

export (Color) var DEACTIVATED_MODULATION_COLOR = "#69ffffff"
export (Color) var ACTIVATED_MODULATION_COLOR = "#ffffff"

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
