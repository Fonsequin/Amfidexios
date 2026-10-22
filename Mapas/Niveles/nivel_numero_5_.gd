extends Node2D

@onready var final = $Transicion/AnimationPlayer2
@onready var tiempo = $Tiempo
var cd = false

func _on_reinicio_timeout():
	final.play("Vtgz")
	tiempo.start()
	await(tiempo.timeout)
	get_tree().reload_current_scene()

func _unhandled_input(event):
	if cd == true:
		if event.is_action_pressed("reiniciar"):
			_reiniciar_juego()
			cd = false
	if event.is_action_pressed("menu"):
			_menu()

func _reiniciar_juego():
	tiempo.start()
	await(tiempo.timeout)
	get_tree().reload_current_scene()


func _on_cd_timeout():
	cd = true


func _on_cronometro_timeout() -> void:
	cd = false

func _menu():
	get_tree().change_scene_to_file("res://Mapas/menu.tscn")
