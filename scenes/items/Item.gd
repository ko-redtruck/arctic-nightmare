extends RigidBody2D

var item_name
var voice_lines = []
#chance between 0-1/0-100%
export (float) var VOICE_LINE_CHANCE = 0.3

func get_in_effect_range(group: String):
	for node in $EffectRadius.get_overlapping_bodies():
		if node.is_in_group(group):
			return node
	for node in $EffectRadius.get_overlapping_areas():
		if node.is_in_group(group):
			return node
	return null

func is_in_effect_range(group: String):
	return get_in_effect_range(group) != null

func play_random_voice_line():
	randomize()
	if rand_range(0, 1.0) < self.VOICE_LINE_CHANCE:
		if len(self.voice_lines) > 0:
			var random_voice_line_index = randi() % len(self.voice_lines)
			var randome_voice_line = self.voice_lines[random_voice_line_index]
			self.voice_lines.remove(random_voice_line_index)
			GameState.play_voice(randome_voice_line)
	
	
func pick_up_on(player):
	print("Picked up by", player)
	self.play_random_voice_line()
	self.get_parent().remove_child(self)
	player.equip(self)
	

func use_on(player):
	print("Used on", player)

func is_usable():
	# print("is Usable")
	return true
