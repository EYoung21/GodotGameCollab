
extends CharacterBody2D

const ACCELERATION = 800
const FRICTION = 1300
const MAX_SPEED = 200

enum {IDLE, RUN}
var state = IDLE

var blend_position : Vector2 = Vector2.ZERO
var blend_pos_paths = [
	"parameters/idle/idle_bs2d/blend_position",
	"parameters/run/run_bs2d/blend_position"
]
var animTree_state_keys = [
	"idle",
	"run"
]

func _physics_process(delta):
	move(delta)

func move(delta):
	var input_vector = Input.get_vector("left", "right", "up", "down")
	if input_vector == Vector2.ZERO:
		state = IDLE
		apply_friction(FRICTION * delta)
	else:
		state = RUN
		apply_movement(input_vector * ACCELERATION * delta)
		blend_position = input_vector
	move_and_slide()


func apply_movement(amount) -> void:
	velocity += amount
	velocity = velocity.limit_length(MAX_SPEED)

func apply_friction(amount) -> void:
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO
