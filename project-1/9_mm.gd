extends CharacterBody3D

@export var speed: float = 280.0
@export var drag: float = 1.0
@export var drop: float = 18.0

var dmg: float = 10.0

@onready var ray = RayCast3D.new()
@onready var decal = preload("res://guns/bullet_decal.tscn")

var spawn_transform
var last_pos

var sender = null

func _ready() -> void:
	add_sibling(ray)

	global_transform = spawn_transform

	velocity = transform.basis * Vector3(0,0,-speed)
	last_pos = position
	ray.global_position = global_position
	#await get_tree().create_timer(0.1).timeout
	#$MeshInstance3D3.visible = true


func _process(delta: float) -> void:
	ray.target_position = global_position - ray.global_position
	ray.position = last_pos
	last_pos = position
	ray.force_raycast_update()
	
	#$trail.scale.z = ray.position.distance_to(ray.target_position) / 2
	#$trail.position = (ray.position + ray.target_position) / 2 #ray.position.distance_to(ray.target_position) * 0.5
	##$trail.rotation = ray.position.angle_to(ray.target_position)
	#$trail.look_at(ray.target_position)
	#
	#$trail
	
	update_trail($trail, ray.global_position, global_position)
	
	velocity.y -= drop * delta
	
	if ray.is_colliding():
		if ray.get_collider().is_in_group("hittable"):
			ray.get_collider().hit(dmg, sender)
		var new_decal = decal.instantiate()
		ray.get_collider().add_child(new_decal)
		new_decal.global_position = ray.get_collision_point()
		#new_decal.look_at(ray.get_collision_point(), ray.get_collision_normal())
		new_decal.look_at(ray.get_collision_point() + ray.get_collision_normal(), Vector3.UP)
		#new_decal.look_at(ray.get_collision_point() + ray.get_collision_normal(), Vector3(1, 1, 1))
		#add_sibling(new_decal)ector3.UP
		#look_at()
		ray.queue_free()
		queue_free()
	
	move_and_slide()

func update_trail(trail: MeshInstance3D, from: Vector3, to: Vector3):
	var direction = to - from
	var length = direction.length()

	if length == 0.0:
		return

	var midpoint = from + direction# * 0.5

	# Position
	trail.global_position = midpoint

	# Rotation (align +Z with the ray direction)
	trail.look_at(to, Vector3.UP)

	# Scale (stretch along Z)
	var scale = trail.scale
	scale.z = length
	trail.scale = scale * 2
