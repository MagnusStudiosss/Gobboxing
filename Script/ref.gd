extends Node3D

@warning_ignore("unused_signal")
signal Countdown
@warning_ignore("unused_signal")
signal Sig3
@warning_ignore("unused_signal")
signal Sig2
@warning_ignore("unused_signal")
signal Sig1
@warning_ignore("unused_signal")
signal Start
@warning_ignore("unused_signal")
signal StartAnim
@warning_ignore("unused_signal")
signal Gun
var Typing = true
const Line1 = "Hey Bros...
Let's Have a
clean fight,
ok?"
const Line2 = "I'm gonna count
to three,then
the gobs will
box"
const Winner = "we have a winner!"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label3D.text = Line1
	$AudioStreamPlayer3D.play()
	await $AudioStreamPlayer3D.finished
	$AudioStreamPlayer3D.stream = load("res://Audio/Dialogue/tts2.mp3")
	$Label3D.text = Line2
	$AudioStreamPlayer3D.play()
	await $AudioStreamPlayer3D.finished
	emit_signal("Countdown")
	$AudioStreamPlayer3D.stream = load("res://Audio/Dialogue/One.mp3")
	emit_signal("Sig3")
	var TimerTime = get_tree().create_timer(1)
	await TimerTime.timeout
	emit_signal("Sig3")
	$Label3D.text = "3"
	$AudioStreamPlayer3D.stream = load("res://Audio/Dialogue/Three.mp3")
	$AudioStreamPlayer3D.play()
	TimerTime = get_tree().create_timer(1)
	await TimerTime.timeout
	$Sprite3D.set("render_priority",-1)
	emit_signal("Sig2")
	$Label3D.text = "2"
	$AudioStreamPlayer3D.stream = load("res://Audio/Dialogue/Two.mp3")
	$AudioStreamPlayer3D.play()
	TimerTime = get_tree().create_timer(1)
	await TimerTime.timeout
	emit_signal("Sig1")
	$Label3D.text = "1"
	$AudioStreamPlayer3D.stream = load("res://Audio/Dialogue/One.mp3")
	$AudioStreamPlayer3D.play()
	TimerTime = get_tree().create_timer(1)
	await TimerTime.timeout
	$Label3D.visible = false
	emit_signal("Start")


func _on_world_win() -> void:
	$Label3D.text = Winner
	$AudioStreamPlayer3D.stream = load("res://Audio/Dialogue/Winner.mp3")
	$AudioStreamPlayer3D.play()
	var TimerTime = get_tree().create_timer(2)
	await TimerTime.timeout
	emit_signal("Gun")
	$AudioStreamPlayer3D.stream = load("res://Audio/Dialogue/oh god.mp3")
	$AudioStreamPlayer3D.play()
