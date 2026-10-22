extends Area2D

@onready var anim = $"../AnimatedSprite2D"
@onready var tiempo = $"../Tiempo"
@onready var collision = $CollisionShape2D

func _on_body_entered(body):
	if body.is_in_group("Player"):
		collision.queue_free()
		tiempo.start()
		await(tiempo.timeout)
		get_tree().change_scene_to_file("res://Mapas/SubNiveles/Nivel_Sub5.tscn")
	pass

#Script para el jugador con el taper en la frente
