extends Node


#region SFX
const ALIEN_SHOT = preload("uid://dr5ir4lfjdqd2")
const BOWSTRING = preload("uid://c55fd37uqiqsn")
const BREAK = preload("uid://d2h8ww57jdtj7")
const CARD_DECLINE = preload("uid://y18g1y1sycbm")
const DEFAULT_1 = preload("uid://ctx8gt2tdfbdw")
const DIG = preload("uid://be4egr8cu5byq")
const DODGE = preload("uid://dkvwh6mkxdpj7")
const DOOR_OPEN = preload("uid://c5swqpt5ea4a3")
const FIRE_BREATH = preload("uid://k42f3nu3td6u")
const GUARD = preload("uid://cpp7e24740j5n")
const GUNSHOT = preload("uid://bgdhr3el1e611")
const HEAL = preload("uid://h0iwjgw503ij")
const HIT = preload("uid://kil02tdo8fiu")
const INVALID = preload("uid://u6faxelwkudd")
const LOAD_GUN = preload("uid://dgrvcwxl0ibif")
const OBJECTIVE_COMPLETE = preload("uid://bbkjkylggath")
const PICKUP = preload("uid://d3w5br7t4dq5q")
const PLAYER_HIT = preload("uid://12xyp1tjk4c3")
const SC_FI_WOOSH = preload("uid://ctrv5cnvq5rew")
const SQUISHY_HIT = preload("uid://cen18igm3v55w")
const STEP = preload("uid://dtif2j1d2yv82")
const SWORD = preload("uid://bkcab2wt1vn2n")
const TERMINAL_BEEP = preload("uid://bcekf4ifundy1")
const TIMES_UP = preload("uid://c8iwxm1gfs1tl")
const TURRET_OPENING = preload("uid://d4hdbr8pro440")
const VENT_OPEN_OR_MISS = preload("uid://0hvce6i6cwpk")
const WELD = preload("uid://c8e8uf5722ws1")

#endregion

#region Music
const FIGHT_LEVEL_1 = preload("uid://blaruh2nbomr8")
const FIGHT_LEVEL_2 = preload("uid://l2d1u0boaqy2")
const FIGHT_LEVEL_3 = preload("uid://bovpyuyw8bvlx")
const SAND_TEST = preload("uid://brj5ayxdyglrf")

#endregion


##Plays [param sound] at the given [param node].
##
##Create a [AudioStreamPlayer2D] as a child of the [param node] and starts playing [param sound]. Then deletes the [AudioStreamPlayer2D] when the audio is done playing.
##To play sound at position set node to root and [param offset] to desired position.
func play_2d(audio_bus:String, node:Node, sound:AudioStream = DEFAULT_1, volume:float = 0, offset:Vector2 = Vector2.ZERO):
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
func play_global(audio_bus:String, sound:AudioStream = DEFAULT_1, volume:float = 0):
	var player:AudioStreamPlayer = AudioStreamPlayer.new()
	player.set_stream(sound)
	player.set_bus(audio_bus)
	player.set_autoplay(true)
	player.set_volume_db(volume)
	#deletes the audio player when sound is done playing
	player.connect("finished",func():self.queue_free())
	self.add_child(player)
