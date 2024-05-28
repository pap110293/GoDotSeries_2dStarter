extends CharacterBody2D

signal health_depeted

const MAX_HEALTH = 100.0
const DAMAGE_RATE = 5.0

var health = MAX_HEALTH

func _ready():
	init_health_bar()

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600;
	move_and_slide()
	
	if velocity.length() > 0.0:
		$HappyBoo.play_walk_animation()
	else:
		$HappyBoo.play_idle_animation()
		
	var overlapping_mods = $HurtBox.get_overlapping_bodies()
	if overlapping_mods.size() > 0:
		health -= DAMAGE_RATE * overlapping_mods.size() * delta
		$ProgressBar.value = health
		if health <= 0:
			health_depeted.emit()
			
func init_health_bar():
	$ProgressBar.max_value = MAX_HEALTH
	$ProgressBar.value = health
