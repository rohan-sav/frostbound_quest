extends Node2D
 
func _ready():
	AudioPlayer.play_music_level() 
	
@export_file var next_level

func level_clear() -> void:
	get_tree().change_scene_to_file(next_level)
 
