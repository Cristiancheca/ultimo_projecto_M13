extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var startselect = preload("res://scenes/menus/startslector.tscn")
var armorshop = preload("res://scenes/menus/armorshop.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$shopbutton.disabled = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#El codigo que hace aparecer al personaje principal 
func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		var player = get_node("player")
		var new_bullet = startselect.instance()
		new_bullet.position = player.global_position
		add_child(new_bullet)


func _on_Areashop_body_entered(body):
	if body.is_in_group("player"):
		$shopbutton.disabled = false
	pass # Replace with function body.


func _on_Areashop_body_exited(body):
	if body.is_in_group("player"):
		$shopbutton.disabled = true
	pass # Replace with function body.

#Una vez clicas el boton de la tienda de armaduras se abre el menu de las armaduras para poder comprarlas
func _on_shopbutton_pressed():
	var player = get_node("player")
	var armorshop0 = armorshop.instance()
	armorshop0.position = player.global_position
	add_child(armorshop0)
	pass # Replace with function body.
