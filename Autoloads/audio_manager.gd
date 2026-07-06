extends Node


#region sounds
#var sound name = sound file path
#endregion


##Plays [param sound] at the given [param node].
##
##Create a [AudioStreamPlayer2D] as a child of the [param node] and starts playing [param sound]. Then deletes the [AudioStreamPlayer2D] when the audio is done playing.
##To play sound at position set node to root and [param offset] to desired position.
func play_2d(sound:AudioStream, audio_bus:String, node:Node, volume:float = 0, offset:Vector2 = Vector2.ZERO):
	var player:AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	player.set_stream(sound)
	player.set_bus(audio_bus)
	player.set_autoplay(true)
	player.set_volume_db(volume)
	#deletes the audio player when sound is done playing
	player.connect("finished",func():self.queue_free())
	player.set_position(offset)
	node.add_child(player)


##Plays the given sound globaly
func play_global(sound:AudioStream, audio_bus:String, volume:float = 0):
	var player:AudioStreamPlayer = AudioStreamPlayer.new()
	player.set_stream(sound)
	player.set_bus(audio_bus)
	player.set_autoplay(true)
	player.set_volume_db(volume)
	#deletes the audio player when sound is done playing
	player.connect("finished",func():self.queue_free())
	self.add_child(player)
