extends KinematicBody2D
#VARIABLE PARA SCRIPT GLOBAL
var global
# Variables para el movimiento
var speed = 130
var velocity = Vector2()

# Variables para la vida del jugador
var score_actual = 0
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
var sword_scene = preload("res://characters/player/items/item_sword.tscn")
var dagger_scene = preload("res://characters/player/items/item_dagger.tscn")
var crossbow_scene = preload("res://characters/player/items/item_crossbow.tscn")
var gameover_scene = preload("res://scenes/menus/gameover.tscn")
var actualskin

func _ready():
	global = get_node("/root/global")
	actualskin = global.skin
	# Obtener el AnimatedSprite
	animated_sprite = $AnimatedSprite
	# Obtener el ProgressBar de la UI
	vida_progressbar = $UI/ProgressBar
	exp_progressbar = $UI/experience
	# Inicializar el ProgressBar con la vida inicial del jugador
	vida_progressbar.value = vida
	exp_progressbar.value = experience
	#SETUP STARTING WEAPON
	if global.startweapon == "sword":
		if global.lvlsword == 0:
			var sword = sword_scene.instance()
			$items.add_child(sword)
			global.lvlsword = global.lvlsword +1
	if global.startweapon == "dagger":
		if global.lvldagger == 0:
			var dagger = dagger_scene.instance()
			$items.add_child(dagger)
			global.lvldagger = global.lvldagger +1
	if global.startweapon == "crossbow":
		if global.lvlcrossbow == 0:
			var crossbow = crossbow_scene.instance()
			$items.add_child(crossbow)
			global.lvlcrossbow = global.lvlcrossbow +1
	
	if get_parent().name == "mercado":
		$UI/itembar.visible = false
		$items.visible = false
		$UI/ProgressBar.visible = false
		$UI/Label.visible = false
		$UI/experience.visible = false
		$Light.modulate = Color(1, 1, 1, 0.06)
		pass
	else:
		$UI/shells.visible = false
		$UI/Timer.start()
		pass
	global.toggle_pause()
	animated_sprite.play(actualskin+"revive")
	yield(animated_sprite,"animation_finished")
	global.toggle_pause()

func _physics_process(delta):
	actualskin = global.skin
	#shells
	$UI/shells.text = str(global.shells)
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
	
	#itembar
	if global.lvlsword >= 1:
		$UI/itembar/icon.play("sword")
		$UI/itembar/icon/Label.text = str(global.lvlsword)
	if global.lvldagger >= 1:
		$UI/itembar/icon2.play("dagger")
		$UI/itembar/icon2/Label.text = str(global.lvldagger)
	if global.lvlcrossbow >=1:
		$UI/itembar/icon3.play("crossbow")
		$UI/itembar/icon3/Label.text = str(global.lvlcrossbow)

func update_animation():
	
	if velocity.length_squared() > 0:
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x > 0:
				animated_sprite.play(actualskin+"walk_right")
				slash_direction = 1
			else:
				animated_sprite.play(actualskin+"walk_left")
				slash_direction = -1
		else:
			if velocity.y > 0:
				animated_sprite.play(actualskin+"walk_down")
			else:
				animated_sprite.play(actualskin+"walk_up")
	else:
		animated_sprite.play(actualskin+"default")

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
			$losesound.play()
			$UI.visible = false
			global.toggle_pause()
			animated_sprite.play(actualskin+"die")
			yield($AnimatedSprite,"animation_finished")
			global.score = score_actual
			var gameover = gameover_scene.instance()
			$items.add_child(gameover)
			# Aquí puedes añadir lógica para el manejo de la muerte del jugador
			pass
#METODO PARA LA POCION DE CURA
func curar_dano(cura):
	if vida < 100:
		vida += cura
		vida_progressbar.value = vida
	pass
#METODO POCION DE SPEED
func more_speed(plusspeed):
	speed += plusspeed
	pass

# Método llamado cuando el Timer termina

func add_exp(amount):
	global.shells = global.shells + 1
	score_actual = score_actual + 100
	experience += amount
	exp_progressbar.value = experience
	if experience >= 10:
		var levelup = levelupchosse_scene.instance()
		$items.add_child(levelup)
		experience = 0
		exp_progressbar.value = experience
		pass
	# Add any additional logic for level up or UI updates here


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
