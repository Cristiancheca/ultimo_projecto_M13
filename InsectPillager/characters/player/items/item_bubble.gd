extends Node2D

const DAMAGE_REPEL_RADIUS = 50
const PUSH_FORCE = 200

func _ready():
	# Connect the timer's timeout signal to the method for spawning the bubble
	$Timer.connect("timeout", self, "_on_Timer_timeout")
	# Start the timer
	$Timer.start()

func _on_Timer_timeout():
	# Spawn the bubble at the player's position
	position = get_parent().position
	# Enable the collision shape
	$CollisionShape2D.disabled = false
	# Play the "on" animation
	$AnimatedSprite.play("on")
	# Disable the collision shape and play the "off" animation after a short delay
	$CollisionShape2D.call_deferred("set_disabled", true)
	$AnimatedSprite.call_deferred("play", "off")
	# Restart the timer for the next bubble spawn
	$Timer.start()

func _on_MagicalBubble_body_entered(body):
	# Check if the colliding body is in the "enemy" group
	if body.is_in_group("enemy"):
		# Calculate the direction from the bubble to the enemy
		var direction = (body.global_position - global_position).normalized()
		# Apply a force to push the enemy away from the bubble
		body.apply_impulse(global_position, direction * PUSH_FORCE)

func _on_MagicalBubble_area_entered(area):
	# Check if the entering area is in the "enemy" group
	if area.is_in_group("enemy"):
		# Repel damage from enemies within the specified radius
		if global_position.distance_to(area.global_position) <= DAMAGE_REPEL_RADIUS:
			area.recibir_danio(10)  # Apply damage to the enemy
