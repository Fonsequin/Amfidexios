extends Area2D

@onready var anim = $"../AnimatedSprite2D"
@onready var tiempo = $"../Tiempo"
@onready var collision = $CollisionShape2D
@onready var final = $"../../Transicion/AnimationPlayer2"

func _on_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://Nivel Numero 3.tscn")
	pass

#Script para el jugador con el taper en la frente
