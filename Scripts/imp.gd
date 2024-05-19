extends Node2D

# Enemy properties
const SPEED = 60
const DETECTION_RADIUS = 150
var damage = 10

# Reference to the player
var player = null

func _ready():
	# Get the player node from the "player" group
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]

	# Ensure the Imp node and connect its signal
	$imp_hitbox.connect("area_entered", self, "_on_Imp_area_entered")

func _process(delta):
	if player:
		var distance_to_player = global_position.distance_to(player.global_position)
		
		if distance_to_player < DETECTION_RADIUS:
			var direction = (player.global_position - global_position).normalized()
			global_position += direction * SPEED * delta

# Function to handle collision with the player
func _on_Imp_area_entered(area):
	if area.is_in_group("player"):
		emit_signal("enemy_hit_player", damage)
