extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Changes the menu screen to the first level of the game by using the change scne to file function
func _on_button_pressed() -> void:
		get_tree().change_scene_to_file("res://levels/level_00.tscn")


func _on_button_2_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	pass
