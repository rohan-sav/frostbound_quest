extends Node2D

func _ready():
	AudioPlayer.play_music_level() 
	
@export_file var next_level

@export var final_time = 0
#Changes scene to the next level at the end of each level when the player touches the door
func level_clear() -> void:
	get_tree().change_scene_to_file(next_level)

 
