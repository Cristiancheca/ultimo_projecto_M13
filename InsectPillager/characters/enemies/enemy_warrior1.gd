extends KinematicBody2D

# Variables para el movimiento
var global
var speed = 30  # Adjust as needed
var player = null
var exp_orb_scene = preload("res://characters/ExpOrb.tscn")
# Variables para el daño
var damage = 10
# Variables para la vida del enemigo
var vida = 40

# Variables para AnimatedSprite
var animated_sprite

func _ready():
	global = get_node("/root/global")
	#AUGMENTAR VIDA I DAÑO SEGUN EL TIEMPO:
	if global.enemylvl >= 1:
		vida = vida * global.enemylvl
		damage = damage * global.enemylvl
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
	$damagesound.play()
	vida -= damage
	$blood.restart()
	$blood.emitting = true
	
	if vida <= 0:
		# Liberar el nodo cuando la vida llega a cero
		# Spawn exp orb at enemy's position
		if randi() % 2 == 0:
			var exp_orb = exp_orb_scene.instance()
			exp_orb.position = global_position
			get_parent().get_parent().call_deferred("add_child", exp_orb)
		
		call_deferred("queue_free")
