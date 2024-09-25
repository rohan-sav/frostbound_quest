extends Area2D

@export var score: int
#Plays the animation fading out the coin when the player touches it
func _on_body_entered(body):
	$AnimationPlayer.play("pick_up")
	score += 1
	print(score)
