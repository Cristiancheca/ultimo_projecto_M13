extends KinematicBody2D

# Variables para el movimiento
var speed = 130
var velocity = Vector2()

# Variables para el AnimatedSprite
var animated_sprite

func _ready():
	# Obtener el AnimatedSprite
	animated_sprite = $AnimatedSprite

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
			else:
				animated_sprite.play("walk_left")
		else:
			if velocity.y > 0:
				animated_sprite.play("walk_down")
			else:
				animated_sprite.play("walk_up")
	else:
		animated_sprite.play("default")
