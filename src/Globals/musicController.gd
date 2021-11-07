extends Node

export (float, 0,5,0.1) var xFadeTime: float = 0.4

var nowPlaying: String

var musicLibrary = {
	"Mainmenu": "res://Assets/music/mainmenu.ogg",
	"Win": "res://Assets/music/win.ogg",
	"Lose": "res://Assets/music/lose.ogg",
	"Stage1": "res://Assets/music/stage1.ogg"
}



func playMusic(music):
	$AudioPlayer.stream = load(musicLibrary[music])
	$AudioPlayer.play()
	$Tween.interpolate_property($AudioPlayer,"volume_db",-80,0,xFadeTime,Tween.TRANS_SINE,Tween.EASE_IN)
	$Tween.start()
	nowPlaying = music
	
	

func changeMusic(changeTo: String, fadeTime: float = xFadeTime):
	if changeTo == nowPlaying:
		return
	if not $AudioPlayer.playing:
		playMusic(changeTo)
	var newMusic = load(musicLibrary[changeTo])
	$Tween.interpolate_property($AudioPlayer,"volume_db",0,-80,fadeTime,Tween.TRANS_SINE,Tween.EASE_IN)
	$Tween.start()
	$AudioPlayer.stream = newMusic
	$AudioPlayer.play()
	$Tween.interpolate_property($AudioPlayer,"volume_db",-80,0,fadeTime,Tween.TRANS_SINE,Tween.EASE_IN)
	$Tween.start()
	nowPlaying = changeTo
