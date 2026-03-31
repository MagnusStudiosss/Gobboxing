extends TextureButton

const Text1 = "Click Left and
right back 
and forth to get
PUNCHPOINTS!"

const Text2 = "At one hundred
percent
PUNCHPOINTS, you
get a health
pack!"

const Text3 = "Also, the goblin
is Gay"

const Text4 = "Also.. Click the
logo to do the
opposite of
unboxing"

func _on_pressed() -> void:
	if $Label.text == Text1:
		$Label.text = Text2
	elif $Label.text == Text2:
		$Label.text = Text3
	elif $Label.text == Text3:
		$Label.text = Text4
	else:
		$Label.text = Text1
