extends Node3D

var sight_pos

@export var mag: PackedScene
@export var sight: PackedScene
@export var muzzle: PackedScene
@export var flash = preload("res://guns/muzzleflash.tscn")
@export var base_flash_size = 0.5


@export var vrecoil = 0.2
@export var hrecoil = 0.04
@export var recoil_reset_speed = 0.4

@onready var bullet = preload("res://guns/9_mm.tscn")
@onready var main = get_tree().get_first_node_in_group("world")
var sender

func _ready() -> void:
	$gun_muzzle.add_child(muzzle.instantiate())
	$gun_sights.add_child(sight.instantiate())
	$gun_mag.add_child(mag.instantiate())
	
	sight_pos = $gun_sights.position
	if $gun_sights.get_child(0) != null:
		sight_pos = $gun_sights.position + $gun_sights.get_child(0).aim_pos


func item_action():
	shoot()

func shoot():
	var new_bullet = bullet.instantiate()
	new_bullet.sender = sender
	new_bullet.spawn_transform = $gun_muzzle.global_transform
	#$bullet_marker/Sprite3D.rotation.z = randi_range(-20, 20)
	main.add_child.call_deferred(new_bullet)
	muzzleflash()
	get_parent().recoil(randf_range(vrecoil * 0.8, vrecoil * 1.2), randf_range(-hrecoil, hrecoil), recoil_reset_speed)
	$gunshot.play()

func muzzleflash():
	var newflash = flash.instantiate()
	#var newflash = flash.instantiate()
	newflash.max_size = base_flash_size
	if muzzle == null:
		$gun_muzzle.add_child(newflash)
	else:
		#newflash.max_size * $gun_muzzle.get_child(0).gun_muzzle.flash_mult
		$gun_muzzle.get_child(0).gun_muzzle.add_child(newflash)
		print("blaaaaa")
