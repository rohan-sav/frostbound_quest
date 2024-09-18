extends AudioStreamPlayer2D

const walking_sfx = preload("res://GLOBAL/running-in-grass-6237.mp3")

func _play_sfx(music: AudioStream, volume = 0.0):
	if stream == music:
		return
		
	stream = music
	volume_db = volume
	play()
	
func play_sfx():
	_play_sfx(walking_sfx)
