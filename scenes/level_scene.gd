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
			sun1.play("default")
		3:
			sun1.play("default")
			sun2.play("default")
		2:
			sun1.play("default")
			sun2.play("default")
			sun3.play("default")
		1:
			sun1.play("default")
			sun2.play("default")
			sun3.play("default")
			sun4.play("default")
		0:
			sun1.play("default")
			sun2.play("default")
			sun3.play("default")
			sun4.play("default")
			sun5.play("default") 
	await Timer(3.5)
	if Global.minigames_done < 3: # if you havent completed 3 minigames yet 
		Global.minigames_done = Global.minigames_done +1
		get_tree().change_scene_to_file("res://scenes/minigame_" + str(Global.minigames_done) + ".tscn") # changes your scene by arranging this frankenstein path. 
# Above, your script is being told to go to the next minigame. If the 
# current minigame is Level 1, then you would be on minigame 1. If you 
# complete that level, you have the minigames_done add one, and then you 
# look for the scene titled `minigame_` and then whatever minigame number 
# should be next. Make sure you name your minigame saves appropriately.

	else:
		get_tree().change_scene_to_file("res://scenes/title_screen.tscn") # changes your scene
	

func _process(_delta: float) -> void: # runs EVERY FRAME

	
	timer.text = str(time) # make ths text reflect the value of the time variable. this makes names easier. the str() converts the int to a String
	level.text = "Level " + str(Global.minigames_done) # this tells you want minigame you're on using concatenation (google the word yo)

func Timer(start_time: float): # making a new function for timer countdown!
	# we want the timer to go down, and when it reaches 0 it transitions 
	# to the next scene!
	
	time = start_time # make the timer, which is reflected through the timer text, start at your desired number
	
	while time > 0.0: # run if timer hasnt reached 0
		await wait(0.1) # asks script to wait on this function. the 'wait' name for the function does nothing here, as await is just telling the scrpit to wait for the function to complete before progressing
		time -= 0.1 # remove 0.1
		# progressively get the value smaller and smaller
	
	#when timer reaches 0
	return

func wait(seconds: float) -> void: # write this simple function out for wait!
	await get_tree().create_timer(seconds).timeout # makes u wait, dw abt this being complex '''
