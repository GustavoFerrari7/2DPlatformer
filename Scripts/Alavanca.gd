extends Area2D


export var estado = ""
#export var level = "Level1"


func _ready():
	if (estado == "1"):
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false
		
func _process(delta):
	#var body = get_tree().get_root().get_node(level).get_node("Personagem")
	if overlaps_body($"../../Personagem") and Input.is_action_just_pressed("Space"):
		if (estado == "0"):
			estado = "1"
			AlavancaGlobal.MudouAlavanca()
		else:
			estado = "0"
			AlavancaGlobal.MudouAlavanca()
		_ready()
		print(estado)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


