extends Area2D

@onready var anim = $"../AnimatedSprite2D"
@onready var tiempo = $"../Tiempo"
@onready var collision = $CollisionShape2D

func _on_body_entered(body):
	if body.is_in_group("Player2"):
		body.Tocar = false
		collision.queue_free()
		anim.play("cambio2")
		tiempo.start()
		await(tiempo.timeout)
		get_tree().change_scene_to_file("res://Mapas/menu.tscn")
	pass

#Script para el jugador ranita
