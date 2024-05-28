extends Node2D

func spawn_mob():
	var new_mod = preload("res://Mod.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mod.global_position = %PathFollow2D.global_position
	add_child(new_mod)


func _on_timer_timeout():
	spawn_mob() # Replace with function body.


func _on_player_health_depeted():
	$GameOverUI.visible = true
	get_tree().paused = true
