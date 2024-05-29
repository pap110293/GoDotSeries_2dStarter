extends Area2D

var is_shooting:bool = false
const BULLET = preload("res://bullet.tscn")
var player
func _ready():
	player =  get_node("/root/Game/Player")
	
func _physics_process(_delta):
	var enemies_in_range = get_overlapping_bodies()
	if(enemies_in_range.size() > 0):
		var tartget_enemy = enemies_in_range.front()
		look_at(tartget_enemy.global_position)
		is_shooting = true
	else:
		is_shooting = false
	
	flipTheGun()

func flipTheGun():
	var scaleY = 1
	if  player.global_position.x > $WeaponPiot/Pistol.global_position.x : 
		scaleY = -1
	
	if scaleY != $WeaponPiot/Pistol.scale.y:
		$WeaponPiot/Pistol.scale = Vector2($WeaponPiot/Pistol.scale.x, scaleY)

func shoot():
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = $WeaponPiot/Pistol/ShootingPoint.global_position
	new_bullet.global_rotation = $WeaponPiot/Pistol/ShootingPoint.global_rotation
	$WeaponPiot/Pistol/ShootingPoint.add_child(new_bullet)


func _on_timer_timeout():
	if is_shooting:
		shoot() # Replace with function body.
