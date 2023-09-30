extends BaseEnemy

func _ready():
	self.add_to_group("Enemy")
	$Model/Cube.add_to_group("Enemy")
	$Model/Decal.add_to_group("Enemy")
	$Model/SpotLight3D.add_to_group("Enemy")
	$Collider.add_to_group("Enemy")
	health = 1
