extends Node2D
 
@export_file var next_level
 
 
func level_clear() -> void:
	get_tree().change_scene_to_file(next_level)
 
