extends CanvasLayer
#Starts with time 0 stored in the variable speedrun_time
var time = Global.speedrun_time
#Connects the label text with the value integer of the speedrun_time
func _physics_process(delta):
	if Global.display_speedrun_timer:
		time = float(time) + delta
		update_ui()
	else:
		$Panel/Label.text = str(Global.speedrun_time_end)
#Updates the label text to the speedrun time 
func update_ui():
	
	var formatted_time = str(time)
	var decimal_index = formatted_time.find(".")
	
	if decimal_index > 0:
		formatted_time = formatted_time.left(decimal_index + 3)
	
	Global.speedrun_time = formatted_time
	
	$Panel/Label.text = formatted_time
	
	#if BaseLevel.next_level == "res://Menu/end_menu.tscn":
		#final_time = formatted_time
		#print(final_time)
	
	
	 
