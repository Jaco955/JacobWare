extends Node2D

@onready var timer: Node2D = $Node2D
@onready var lamp: Area2D = $Area2D

var is_hovering := false
var rub_progress := 0.0
var rub_goal := 2500.0
var last_mouse_pos := Vector2.ZERO
var timer_end := false
var level_finished := false

func _ready() -> void:
	lamp.mouse_entered.connect(_on_lamp_mouse_entered)
	lamp.mouse_exited.connect(_on_lamp_mouse_exited)
	last_mouse_pos = get_global_mouse_position()
	
	await timer.Timer(7.0)
	timer_end = true

func _on_lamp_mouse_entered() -> void:
	is_hovering = true
	last_mouse_pos = get_global_mouse_position()

func _on_lamp_mouse_exited() -> void:
	is_hovering = false

func _process(_delta: float) -> void:
	if level_finished:
		return
		
	var current_mouse_pos = get_global_mouse_position()
	
	if is_hovering:
		var distance = current_mouse_pos.distance_to(last_mouse_pos)
		if distance > 0:
			rub_progress += distance
			lamp.scale = Vector2(1.1, 1.1)
		else:
			lamp.scale = Vector2(1.0, 1.0)
	else:
		lamp.scale = Vector2(1.0, 1.0)
		
	last_mouse_pos = current_mouse_pos
	
	if rub_progress >= rub_goal:
		level_finished = true
		get_tree().change_scene_to_file("res://scenes/done_screen.tscn")
		
	elif timer_end:
		level_finished = true
		Global.lives -= 1
		Global.minigames_done -= 1
		get_tree().change_scene_to_file("res://scenes/level_scene.tscn")
