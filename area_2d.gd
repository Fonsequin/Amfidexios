extends Area2D

@onready var anim = $"../AnimatedSprite2D"
@onready var tiempo = $"../Tiempo"
@onready var collision = $CollisionShape2D
@onready var final = $"../../Transicion/AnimationPlayer2"

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.Tocar = false
		collision.queue_free()
		anim.play("cambio")
		final.play("Vtgz")
		tiempo.start()
		await(tiempo.timeout)
		get_tree().reload_current_scene()
	pass

#Script para el jugador con el taper en la frente
