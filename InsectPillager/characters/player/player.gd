extends KinematicBody2D
#VARIABLE PARA SCRIPT GLOBAL
var global
# Variables para el movimiento
var speed = 130
var velocity = Vector2()

# Variables para la vida del jugador
var vida = 100
var experience = 0
var levelupchosse_scene = preload("res://characters/player/levelupchosse.tscn")
var inmune = false
# ProgressBar de la UI para mostrar la vida
var vida_progressbar
var exp_progressbar
var animated_sprite

var seconds = 0
var minutes = 0
# Variables for the slash animation
var is_slashing = false
var slash_direction = 1  # 1 for right, -1 for left
var sword_damage = 10

# Variables for the Timer
var slash_timer
#ITEMS!!!
var item_sword = preload("res://characters/player/items/item_sword.tscn")

# Áreas 2D para las colisiones con la espada
var left_area
var right_area

func _ready():
	global = get_node("/root/global")
	# Obtener el AnimatedSprite
	animated_sprite = $AnimatedSprite
	# Obtener el ProgressBar de la UI
	vida_progressbar = $UI/ProgressBar
	exp_progressbar = $UI/experience
	# Inicializar el ProgressBar con la vida inicial del jugador
	vida_progressbar.value = vida
	exp_progressbar.value = experience

	# Start the Timer
	$UI/Timer.start()
	
	if get_parent().name == "mercado":
		$items.visible = false
		$UI/ProgressBar.visible = false
		$Light.modulate = Color(1, 1, 1, 0.06)
		pass

func _physics_process(delta):
	#LEVELUP
	
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
	if inmune == false:
		vida -= damage
		# Actualizar el valor del ProgressBar de la UI con la vida actual del jugador
		vida_progressbar.value = vida
		inmune = true
		# Modulate the AnimatedSprite to grey semi-transparent color
		$AnimatedSprite.modulate = Color(3, 3, 3, 0.5)
		$Inmunity.start()
		if vida <= 0:
			# Aquí puedes añadir lógica para el manejo de la muerte del jugador
			pass
#METODO PARA LA POCION DE CURA
func curar_dano(cura):
	vida += cura
	vida_progressbar.value = vida
	pass

# Método llamado cuando el Timer termina

func add_exp(amount):
	experience += amount
	exp_progressbar.value = experience
	if experience >= 10:
		var levelup = levelupchosse_scene.instance()
		$items.add_child(levelup)
		experience = 0
		exp_progressbar.value = experience
		pass
	# Add any additional logic for level up or UI updates here

# Método llamado cuando el Timer termina



func _on_Button_pressed():
	add_exp(10)
#	var item_instance = item_sword.instance()
#	$items.add_child(item_instance)
	pass # Replace with function body.


func _on_Timer_timeout():
	seconds += 1
	 # Calcula los minutos y segundos
	minutes = seconds / 60
	var remaining_seconds = seconds % 60
	# Increase global.enemylvl by 1 every minute
	if remaining_seconds == 0:  # Check if it's a new minute
		global.enemylvl = global.enemylvl +1
		print(global.enemylvl)
	# Actualiza el texto del contador de tiempo
	$UI/Label.text = str(minutes) + ":" + str(remaining_seconds).pad_zeros(2)
	# Reinicia el temporizador para contar el siguiente segundo
	$UI/Timer.start()


func _on_Inmunity_timeout():
	# Return the AnimatedSprite to its normal color
	$AnimatedSprite.modulate = Color(1, 1, 1, 1)
	inmune = false
	pass # Replace with function body.
