extends KinematicBody2D

# Variables para el movimiento
var speed = 70  # Adjust as needed
var player = null

# Variables para el daño
var damage = 10
# Variables para la vida del enemigo
var vida = 1

# Variables para AnimatedSprite
var animated_sprite

func _ready():
	# Obtener el AnimatedSprite
	animated_sprite = $AnimatedSprite

	# Find the player within the scene
	player = get_tree().get_nodes_in_group("player")[0]  # Assuming there's only one player in the group

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

func _on_Enemy_body_entered(body):
	if body.is_in_group("player"):
		player.recibir_danio(damage)


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.recibir_danio(damage)
# Método para recibir daño

func recibir_danio(damage):
	vida -= damage
	if vida <= 0:
		# Liberar el nodo cuando la vida llega a cero
		$AnimatedSprite.visible = false
		queue_free()
