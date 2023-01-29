extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
var posicaoInicial
var PodeEstado = true
var estadoReset = false

# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_to_group("Pedras")
	set_can_sleep(true)
	posicaoInicial = get_global_transform()
	PersonagemGlobal.connect("resetPedras", self, "resetar")


func _integrate_forces(state):
	if estadoReset:
		state.transform = posicaoInicial
		estadoReset = false
		set_can_sleep(true)
	
func resetar():
	estadoReset = true
	set_can_sleep(false)
	print("aaaaaaaa")
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
