extends Node2D
@onready var sunholder: HBoxContainer = $sunholder
@onready var sun1: AnimatedSprite2D = $sunholder/sun1
@onready var sun2: AnimatedSprite2D = $sunholder/sun2
@onready var sun3: AnimatedSprite2D = $sunholder/sun3
@onready var sun4: AnimatedSprite2D = $sunholder/sun4
@onready var sun5: AnimatedSprite2D = $sunholder/sun5
@onready var level: RichTextLabel = $level
@onready var timer: RichTextLabel = $Timer

var time

func _ready() -> void:
	var last_frame = sun1.sprite_frames.get_frame_count("default") - 1
	sun1.stop() 
	sun1.frame=0
	sun2.stop()
	sun2.frame=0
	sun3.stop()
	sun3.frame=0
	sun4.stop()
	sun4.frame=0
	sun5.stop()
	sun5.frame=0
	match Global.lives: 
		4:
			if Global.lost_lives > 4:
				sun1.play("default")
			else:
				sun1.frame = last_frame
		3:
			sun1.frame = last_frame
			if Global.lost_lives > 3:
				sun2.play("default")
			else:
				sun2.frame = last_frame
		2:
			sun1.frame = last_frame
			sun2.frame = last_frame
			if Global.lost_lives > 2:
				sun3.play("default")
			else:
				sun3.frame = last_frame
		1:
			sun1.frame = last_frame
			sun2.frame = last_frame
			sun3.frame = last_frame
			if Global.lost_lives > 1:
				sun4.play("default")
			else:
				sun4.frame = last_frame
		0:
			sun1.frame = last_frame
			sun2.frame = last_frame
			sun3.frame = last_frame
			sun4.frame = last_frame
			if Global.lost_lives > 0:
				sun5.play("default")
			else:
				sun5.frame = last_frame

	Global.lost_lives = Global.lives
	await Timer(3.5)
	if Global.lives <= 0:
		get_tree().change_scene_to_file("res://scenes/lose_scene.tscn")
	elif Global.minigames_done < 3:
		Global.minigames_done = Global.minigames_done +1
		get_tree().change_scene_to_file("res://scenes/minigame_" + str(Global.minigames_done) + ".tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/title_screen.tscn")

func _process(_delta: float) -> void:
	timer.text = str(time)
	level.text = "Level " + str(Global.minigames_done)

func Timer(start_time: float):
	time = start_time
	while time > 0.0:
		await wait(0.1)
		time -= 0.1
	return

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
