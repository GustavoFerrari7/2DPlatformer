extends Button



func _on_Play_pressed():
	PersonagemGlobal.moedas = 0
	PersonagemGlobal.vidas = 3
	get_tree().change_scene("res://Cenas/Level1.tscn")
