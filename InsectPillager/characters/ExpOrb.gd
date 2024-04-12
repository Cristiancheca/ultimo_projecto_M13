extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var exp_amount = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.add_exp(exp_amount)
		queue_free()
