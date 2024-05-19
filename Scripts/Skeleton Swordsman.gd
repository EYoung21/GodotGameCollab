extends Node2D

const SPEED = 50

var direction = 1

@onready var ray_cast_right = $RayCast_right
@onready var ray_cast_left = $RayCast_left
@onready var animated_sprite = $AnimatedSprite2D

# creates movement, multiply by delta to have a fixed speed.
func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false

	position.x += direction * SPEED * delta

