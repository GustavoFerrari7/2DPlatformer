extends Node

var moedas = 0
var vidas = 3
var podeAtacar = true
var t = Timer.new()
signal pegouMoeda()
signal resetPedras()
signal perdeuVida()

func resetarP():
	emit_signal("resetPedras")

func PerderVida():
	vidas = vidas -1
	print(vidas)
	print(Checkpoint.ultimaPosicao)
	emit_signal("perdeuVida")
	if vidas == 0:
		Checkpoint.ultimaPosicao = Checkpoint.posInicial
		print(Checkpoint.ultimaPosicao)
		get_tree().change_scene("res://Cenas/GameOver.tscn")

func ataque():
	yield(get_tree().create_timer(0.2), "timeout")
	podeAtacar = true
	
