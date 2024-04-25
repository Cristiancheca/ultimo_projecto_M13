extends Control


# Archivo de la bala (tscn)
var bullet_scene = preload("res://characters/arrow.tscn")

# Tiempo entre cada spawn de bala (en segundos)
const SPAWN_INTERVAL = 0.5
# Timer para controlar el spawn de balas
var spawn_timer

func _ready():
	# Crear y configurar el temporizador
	spawn_timer = Timer.new()
	spawn_timer.wait_time = SPAWN_INTERVAL
	spawn_timer.one_shot = false
	spawn_timer.connect("timeout", self, "_on_spawn_timer_timeout")
	add_child(spawn_timer)
	spawn_timer.start()

func _on_spawn_timer_timeout():
	# Instanciar la bala y agregarla al escenario
	var new_bullet = bullet_scene.instance()
	new_bullet.position = $Node2D.global_position
	get_parent().get_parent().get_parent().add_child(new_bullet)
