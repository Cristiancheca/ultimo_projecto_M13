extends KinematicBody2D

# Variables for movement
var speed = 70  # Adjust as needed
var player = null

# Variables for AnimatedSprite
var animated_sprite

func _ready():
	# Get the AnimatedSprite
	animated_sprite = $AnimatedSprite

	# Find the player within the scene
	player = get_parent().get_node("player")  # Assuming the player is a sibling node named "player"

func _physics_process(delta):
	if player:
		# Calculate direction to player
		var direction = (player.global_position - global_position).normalized()

		# Move towards the player
		move_and_slide(direction * speed)

		# Update animation based on direction
		update_animation(direction)

func update_animation(direction):
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			animated_sprite.play("walk_right")
		else:
			animated_sprite.play("walk_left")
	else:
		if direction.y > 0:
			animated_sprite.play("walk_down")
		else:
			animated_sprite.play("walk_up")
