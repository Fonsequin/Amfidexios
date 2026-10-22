extends Node2D

func _process(delta: float) -> void:
	pass


func _on_timer_timeout():
	$AnimationPlayer2.play("GZVT")

func _on_temporizador_timeout():
	get_tree().change_scene_to_file("res://Mapas/Niveles/Nivel Numero 1.tscn")
