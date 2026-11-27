extends Node2D

@onready var themed_timer: Node2D = $minitimer
var batteries_collected = 0
var timer_end = false

func _ready() -> void:
	await themed_timer.Timer(10.0)
	timer_end = true

func _process(delta: float) -> void:
	# CAMBIA ESTE 3 por el número total de baterías que pusiste en tu mapa (ej. 7)
	if batteries_collected == 7:
		if Global.minigames_done > 3:
			get_tree().change_scene_to_file("res://scenes/done.tscn")
		else:
			get_tree().change_scene_to_file("res://scenes/level_scene.tscn")
			
	if timer_end:
		Global.minigames_done -= 1
		Global.lives -= 1
		get_tree().change_scene_to_file("res://scenes/level_scene.tscn")

func _on_battery_battery_collected() -> void:
	batteries_collected += 1
