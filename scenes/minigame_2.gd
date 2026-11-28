extends Node2D

@onready var timer: Node2D = $Node2D

var buttons_pressed := 0
var timer_end = false
var level_finished = false

func _ready() -> void:
	for child in get_children():
		if child is Button:
			if child.pressed.is_connected(_on_button_pressed):
				child.pressed.disconnect(_on_button_pressed)
			child.pressed.connect(_on_single_button_pressed.bind(child))
			
			if child.has_node("AnimatedSprite2D"):
				var sprite: AnimatedSprite2D = child.get_node("AnimatedSprite2D")
				sprite.stop()
				sprite.frame = 0
			
	await timer.Timer(8.0)
	timer_end = true

func _on_button_pressed() -> void:
	pass

func _on_single_button_pressed(button: Button) -> void:
	if button.disabled:
		return
		
	button.disabled = true
	buttons_pressed += 1
	
	if button.has_node("AnimatedSprite2D"):
		var anim_sprite: AnimatedSprite2D = button.get_node("AnimatedSprite2D")
		anim_sprite.frame = 0
		anim_sprite.play("default")
		await anim_sprite.animation_finished
		
	button.hide()

func _process(_delta: float) -> void:
	if level_finished:
		return
		
	if buttons_pressed == 11:
		level_finished = true
		if Global.minigames_done > 3:
			get_tree().change_scene_to_file("res://scenes/done_screen.tscn")
		else:
			get_tree().change_scene_to_file("res://scenes/level_scene.tscn")
			
	elif timer_end:
		level_finished = true
		Global.lives -= 1
		Global.minigames_done -= 1
		get_tree().change_scene_to_file("res://scenes/level_scene.tscn")
