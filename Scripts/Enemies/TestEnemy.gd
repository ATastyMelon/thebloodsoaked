class_name BaseEnemy extends Node3D

var health = 100

func _ready():
	pass
	
func _process(_delta):
	if health <= 0:
		queue_free()
