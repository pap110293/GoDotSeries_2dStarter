extends Area2D

var is_shooting:bool = false

func _physics_process(_delta):
	var enemies_in_range = get_overlapping_bodies()
	if(enemies_in_range.size() > 0):
		var tartget_enemy = enemies_in_range.front()
		look_at(tartget_enemy.global_position)
		is_shooting = true
	else:
		is_shooting = false

func shoot():
	const BULLET = preload("res://bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = $WeaponPiot/Pistol/ShootingPoint.global_position
	new_bullet.global_rotation = $WeaponPiot/Pistol/ShootingPoint.global_rotation
	$WeaponPiot/Pistol/ShootingPoint.add_child(new_bullet)


func _on_timer_timeout():
	if is_shooting:
		shoot() # Replace with function body.
