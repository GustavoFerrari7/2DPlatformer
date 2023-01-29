extends Area2D

func _on_EndLevel_body_entered(body):
	print("aaaaaaaaa")
	get_tree().change_scene("res://Cenas/YouWin.tscn")
