extends Area2D
var checkAtivo

func _ready():
	checkAtivo = 0
	$AnimatedSprite.play("Desativado")
	Checkpoint.ultimaPosicao = Vector2(24,34)
	
	
func _on_CheckpointPedra_body_entered(body):
	if(not checkAtivo):
		Checkpoint.ultimaPosicao = global_position
		#print(Checkpoint.ultimaPosicao)
		checkAtivo = 1
		_entrou()

func _entrou():
	if (checkAtivo):
		$SoundCheckpoint.play()
		$AnimatedSprite.play("Ativado")
		$Light2D.set_energy(1)
