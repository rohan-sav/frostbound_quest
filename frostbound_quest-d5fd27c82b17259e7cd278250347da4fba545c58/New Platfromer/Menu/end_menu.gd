extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Changes the end screen to the menu screen to play the game again
func _on_button_pressed() -> void:
		get_tree().change_scene_to_file("res://Menu/main_menu.tscn")

func _on_button_3_pressed() -> void:
	pass # Replace with function body.
