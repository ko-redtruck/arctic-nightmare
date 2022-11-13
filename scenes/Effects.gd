extends Node

onready var all = [
	StrongGravityEffect.new(),
	LowGravityEffect.new(),
	NoGravityEffect.new(),
	AntiGravityEffect.new(),
	BounceEffect.new(),
	NegativeFrictionEffect.new(),
]

class Effect:
	func apply(obj: RigidBody2D):
		pass
	
	func add_physics_material(obj: RigidBody2D):
		if obj.physics_material_override == null:
			obj.physics_material_override = PhysicsMaterial.new()

class StrongGravityEffect extends Effect:
	func apply(obj: RigidBody2D):
		obj.gravity_scale *= 2.5

class LowGravityEffect extends Effect:
	func apply(obj: RigidBody2D):
		obj.gravity_scale *= 0.1

class NoGravityEffect extends Effect:
	func apply(obj: RigidBody2D):
		obj.gravity_scale = 0

class AntiGravityEffect extends Effect:
	func apply(obj: RigidBody2D):
		obj.gravity_scale *= -1

class BounceEffect extends Effect:
	func apply(obj: RigidBody2D):
		add_physics_material(obj)
		obj.physics_material_override.bounce = 1

class NoFrictionEffect extends Effect:
	func apply(obj: RigidBody2D):
		add_physics_material(obj)
		obj.physics_material_override.friction = 0

class NegativeFrictionEffect extends Effect:
	func apply(obj: RigidBody2D):
		add_physics_material(obj)
		obj.physics_material_override.friction = -1
