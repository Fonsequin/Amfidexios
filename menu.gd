extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_jugar_pressed() -> void:
	$Transiciones/AnimationPlayer.play("GONZIII Y C")
	$Timer.start()


func _on_opciones_pressed() -> void:
	get_tree().change_scene_to_file("res://Mapas/controles.tscn")


func _on_salir_pressed() -> void:
	$Transiciones/AnimationPlayer.play("GONZIII Y C")
	$Transiciones/Cronometro2.start()

func _unhandled_input(event):
	if event.is_action_pressed("reiniciar"):
		_reiniciar_juego()

func _reiniciar_juego():
	get_tree().change_scene_to_file("res://Mapas/Niveles.tscn")

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Mapas/Inicio.tscn")


func _on_cronometro_2_timeout() -> void:
	get_tree().quit()
