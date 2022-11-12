extends Node

onready var all = [
	StrongGravityEffect.new(),
	LowGravityEffect.new(),
	NoGravityEffect.new(),
	AntiGravityEffect.new(),
	BounceEffect.new(),
	NoFrictionEffect.new(),
	NegativeFrictionEffect.new(),
]

class Effect:
	func apply(obj: RigidBody2D):
		pass

class StrongGravityEffect:
	func apply(obj: RigidBody2D):
		obj.gravity_scale = 1.6

class LowGravityEffect:
	func apply(obj: RigidBody2D):
		obj.gravity_scale = 0.4

class NoGravityEffect:
	func apply(obj: RigidBody2D):
		obj.gravity_scale = 0

class AntiGravityEffect:
	func apply(obj: RigidBody2D):
		obj.gravity_scale = -1

class BounceEffect:
	func apply(obj: RigidBody2D):
		obj.physics_material_override.bounce = 1

class NoFrictionEffect:
	func apply(obj: RigidBody2D):
		obj.physics_material_override.friction = 0

class NegativeFrictionEffect:
	func apply(obj: RigidBody2D):
		obj.physics_material_override.friction = -1
