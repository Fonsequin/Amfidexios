extends Area2D

@export var next_scene_path: String


func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.Tocar2 = true
	elif body.is_in_group("Player2"):
		body.Tocar3 = true
	if body.is_in_group("Player2") and body.is_in_group("Player"):
		$"../../Tiempo".start()
		await($"../../Tiempo".timeout)
		get_tree().change_scene_to_file("res://Mapas/menu.tscn")
pass
