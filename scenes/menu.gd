extends Node2D

@onready var slider: HSlider = $VBoxContainer/PanelContainer/HSlider
var bus_index: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bus_index = AudioServer.get_bus_index("Music")
	slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))

func _on_h_slider_value_changed(value:float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))

func _on_mute_pressed() -> void:
	slider.value = 0.0
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(0.0))


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/node_2d.tscn")


func _on_default_pressed() -> void:
	slider.value = 0.5
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(0.5))


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credit_scene.tscn")
