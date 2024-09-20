extends Node2D

func _ready():
	AudioPlayer.play_music_level() 
	
@export_file var next_level

@export var final_time = 0

func level_clear() -> void:
	get_tree().change_scene_to_file(next_level)
	
	#if next_level == "res://Menu/end_menu.tscn":
		#SpeedrunTimer.formatted_time = str(final_time)
		#print(final_time)
		
 
