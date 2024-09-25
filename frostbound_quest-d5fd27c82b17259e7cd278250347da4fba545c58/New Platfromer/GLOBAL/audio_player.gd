extends AudioStreamPlayer2D

const level_music = preload("res://GLOBAL/Frostbound_.mp3")
#Plays the audio at the start of the game and continues throughout each level until the audio track finishes
func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
		
	stream = music
	volume_db = volume
	play()
	
func play_music_level():
	_play_music(level_music)
