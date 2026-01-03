extends Node3D

var recovery_speed = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$"../root_gun_pos"
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if rotation != Vector3.ZERO:
		print(rotation)
		rotation = rotation.move_toward(Vector3.ZERO, recovery_speed * delta)
		

func recoil(vrecoil, hrecoil, recovery):
	rotation.x = vrecoil
	rotation.y = hrecoil
	recovery_speed = recovery
	#$"../../../../gun_follow".position.y += vrecoil
	
	#$"../root_gun_pos".position.y += vrecoil
