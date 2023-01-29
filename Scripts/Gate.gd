extends Node2D

var aberto = false
export var codigo = "0"
var codigoAlavancas = ""
export var pathObjeto = ""
var objetos = []
var a = ""
export var tipo = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	a = "../"+pathObjeto
	objetos = get_node("../"+(pathObjeto)+"").get_children()
	AlavancaGlobal.connect("MudouAlavanca", self, "ChecarCodigo")
	AlavancaGlobal.connect("MudouBotao", self, "ChecarCodigoBotao")
	#for alavanca in objetos:
		#print(alavanca.name, " ", alavanca.estado)

func ChecarCodigo():
	var CodigoAlavancas = ""
	for alavanca in objetos:
		CodigoAlavancas +=alavanca.estado
	if codigo == CodigoAlavancas and !aberto:
		$AnimatedSprite.play("Opening")
		$SoundGate.play()
		aberto = true
	
func ChecarCodigoBotao():
	var CodigoBotao = ""
	for botao in objetos:
		CodigoBotao =botao.estado
		#print(CodigoBotao)
	if codigo == CodigoBotao and !aberto:
		$AnimatedSprite.play("Opening")
		$SoundGate.play()
		aberto = true
	elif codigo != CodigoBotao and aberto:
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
		$AnimatedSprite.play("Closing")
		$SoundGate.play()
		$StaticBody2D.set_collision_layer_bit(0,false)
		$StaticBody2D.set_collision_layer_bit(3,true)
		$StaticBody2D.set_collision_mask_bit(0,true)
		aberto = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Opening" and tipo == "":
		queue_free()
	elif $AnimatedSprite.animation == "Opening" and tipo == "Botao":
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
		$AnimatedSprite.play("Missing")
		$SoundGate.stop()
	elif $AnimatedSprite.animation == "Closing" and tipo == "Botao":
		$AnimatedSprite.play("Closed")
		$SoundGate.stop()
