extends Area2D

var is_shooting:bool = false
const BULLET = preload("res://bullet.tscn")
var player
func _ready():
	player =  get_node("/root/Game/Player")
	
func _physics_process(_delta):
	flipTheGun()
	

func _process(delta):
	var tartget_enemy = find_nearest_enemy()
	if tartget_enemy:
		look_at(tartget_enemy.global_position)
		is_shooting = true
	else:
		is_shooting = false

func find_nearest_enemy():
	var enemies_in_range = get_overlapping_bodies()
	var nearest_body = null
	if(enemies_in_range.size() > 0):
		var closest_distance = INF
		for enemy in enemies_in_range:
			var distance = global_position.distance_to(enemy.global_position)
			if distance < closest_distance:
				closest_distance = distance
				nearest_body = enemy
	return nearest_body

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
