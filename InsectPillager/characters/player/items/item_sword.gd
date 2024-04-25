extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var sword_damage = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_Timer_timeout():
	print("TIMER TIMEOUT")
	yield(get_tree(), "idle_frame")  # Wait for the current frame to finish processing
	$AnimatedSprite.play("swipe")
	$Area2D.monitorable = true
	$Area2D.monitoring = true
	yield($AnimatedSprite, "animation_finished")
	print("IS SLASHING FALSE")
	$AnimatedSprite.play("default")
	$Area2D.monitorable = false
	$Area2D.monitoring = false
	
	
	$Timer.start()

# Método llamado cuando el área 2D de la derecha detecta una colisión
func _on_Area2D_body_entered(body):
	if body.is_in_group("enemy"):
		body.recibir_danio(sword_damage)
	for body in $Area2D.get_overlapping_bodies():
			if body.is_in_group("enemy"):
				body.recibir_danio(sword_damage)
	pass