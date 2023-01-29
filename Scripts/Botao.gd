extends Area2D

var estado = "0"
export var pathPedras = "../../Pedras"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("Released") # Replace with function body.

#func _process(delta):
#	var pedras = get_node(pathPedras).get_children()
#	for pedra in pedras:
#		if overlaps_body(pedra):
#			print("yes")
#			estado = "1"
#			AlavancaGlobal.MudouBotao()
#			$AnimatedSprite.play("Pressed")
#		else:
#			print("no")
#			estado = "0"
#			AlavancaGlobal.MudouBotao()
#			$AnimatedSprite.play("Released")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Botao_body_entered(body):
	estado = "1"
	AlavancaGlobal.MudouBotao()
	$AnimatedSprite.play("Pressed")
	$SoundBotao.play()


func _on_Botao_body_exited(body):
	estado = "0"
	AlavancaGlobal.MudouBotao()
	$AnimatedSprite.play("Released")
	$SoundBotao.play()
