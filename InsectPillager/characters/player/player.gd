extends KinematicBody2D

# Variables para el movimiento
var speed = 130
var velocity = Vector2()

# Variables para la vida del jugador
var vida = 100

# ProgressBar de la UI para mostrar la vida
var vida_progressbar

# Variables para el AnimatedSprite
var animated_sprite
# Variables for the slash animation
var is_slashing = false
var slash_direction = 1  # 1 for right, -1 for left
var sword_damage = 100

# Variables for the Timer
var slash_timer

# Áreas 2D para las colisiones con la espada
var left_area
var right_area

func _ready():
	# Obtener el AnimatedSprite
	animated_sprite = $AnimatedSprite

	# Obtener el ProgressBar de la UI
	vida_progressbar = $UI/ProgressBar

	# Inicializar el ProgressBar con la vida inicial del jugador
	vida_progressbar.value = vida

	# Obtener las áreas 2D
	left_area = $items/item_sword/left
	right_area = $items/item_sword/right
	left_area.set_monitorable(false)
	right_area.set_monitorable(false)

	# Conectar las señales de las áreas 2D
	left_area.connect("body_entered", self, "_on_left_body_entered")
	right_area.connect("body_entered", self, "_on_right_body_entered")

	# Obtener el Timer node
	slash_timer = $items/item_sword/Timer
	# Connect the timeout signal to the method _on_SlashTimer_timeout
	# Start the Timer
	slash_timer.start()

func _physics_process(delta):
	# Control de movimiento
	velocity = Vector2()
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	
	velocity = velocity.normalized() * speed
	move_and_slide(velocity)

	# Actualizar la animación del AnimatedSprite
	update_animation()

func update_animation():
	if velocity.length_squared() > 0:
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x > 0:
				animated_sprite.play("walk_right")
				slash_direction = 1
			else:
				animated_sprite.play("walk_left")
				slash_direction = -1
		else:
			if velocity.y > 0:
				animated_sprite.play("walk_down")
			else:
				animated_sprite.play("walk_up")
	else:
		animated_sprite.play("default")

# Método para recibir daño
func recibir_danio(damage):
	vida -= damage
	# Actualizar el valor del ProgressBar de la UI con la vida actual del jugador
	vida_progressbar.value = vida
	if vida <= 0:
		# Aquí puedes añadir lógica para el manejo de la muerte del jugador
		pass

# Método llamado cuando el Timer termina
# Método llamado cuando el Timer termina
# Método llamado cuando el Timer termina
# Método llamado cuando el Timer termina
func _on_Timer_timeout():
	# Toggle entre los cortes de izquierda y derecha
	if is_slashing:
		# Dejar de cortar
		is_slashing = false
		left_area.set_monitorable(false)
		right_area.set_monitorable(false)
	else:
		# Comenzar a cortar
		is_slashing = true
		# Reproducir la animación de corte basada en la dirección
		if slash_direction == 1:
			# Reproducir la animación de corte a la derecha
			$items/item_sword/AnimatedSprite.play("right")
			left_area.set_monitorable(false) # Desactivar detección de colisiones en el área izquierda
			right_area.set_monitorable(true) # Activar detección de colisiones en el área derecha
			
			# Verificar si hay enemigos dentro del área derecha al iniciar el corte
			for body in right_area.get_overlapping_bodies():
				if body.is_in_group("enemy"):
					body.recibir_danio(sword_damage)
					
		else:
			# Reproducir la animación de corte a la izquierda
			$items/item_sword/AnimatedSprite.play("left")
			right_area.set_monitorable(false) # Desactivar detección de colisiones en el área derecha
			left_area.set_monitorable(true) # Activar detección de colisiones en el área izquierda
			
			# Verificar si hay enemigos dentro del área izquierda al iniciar el corte
			for body in left_area.get_overlapping_bodies():
				if body.is_in_group("enemy"):
					body.recibir_danio(sword_damage)

# Método llamado cuando el área 2D de la izquierda detecta una colisión
func _on_left_body_entered(body):
	if is_slashing:
		if body.is_in_group("enemy"):
			body.recibir_danio(sword_damage)
	pass

# Método llamado cuando el área 2D de la derecha detecta una colisión
func _on_right_body_entered(body):
	if is_slashing:
		if body.is_in_group("enemy"):
			body.recibir_danio(sword_damage)
	pass
