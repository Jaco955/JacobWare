extends Node2D

@onready var player: CharacterBody2D = $"../Player"
@onready var sprite = $batery
@onready var self_area = $batery/Area2D
@onready var player_area = $"../Player/Area2D"

signal battery_collected

var time := 0.0

func _ready() -> void:
	time = randf() * 10.0

func _process(delta: float) -> void:
	
	time += delta * 4.0
	sprite.position.y = sin(time) * 8.0
	
	
	if player_area.overlaps_area(self_area):
		if self.visible:
			emit_signal("battery_collected")
			self.hide()
