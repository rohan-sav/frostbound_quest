extends Node2D
 
func _ready():
	AudioPlayer.play_music_level() 
	
@export_file var next_level

func level_clear() -> void:
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file(next_level)
 
