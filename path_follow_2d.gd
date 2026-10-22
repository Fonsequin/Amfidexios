extends PathFollow2D

var velocidad = 0.5

func _process(delta):
	progress_ratio += delta * velocidad
