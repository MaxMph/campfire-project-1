extends Node3D

var scale_randomization = 1.0
var fade_speed = 0.6

var start_fade = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#$MeshInstance3D.rotation.x = deg_to_rad(randi_range(0, 4) * 90)
	#var rand_scale = randf_range(1.0, scale_randomization)
	#scale = Vector3(rand_scale, rand_scale, rand_scale)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $MeshInstance3D.transparency < 1.0 and start_fade == true:
		$MeshInstance3D.transparency += delta * fade_speed


func _on_timer_timeout() -> void:
	start_fade = true
