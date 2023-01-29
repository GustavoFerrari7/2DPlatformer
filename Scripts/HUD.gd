extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _on_pegouMoeda():
	$Panel/moedas.text = String(PersonagemGlobal.moedas)
func _on_perdeuVida():
	$Panel2/Vidas.text = String(PersonagemGlobal.vidas)
func _ready():
	$Panel/moedas.text = String(PersonagemGlobal.moedas)
	$Panel2/Vidas.text = String(PersonagemGlobal.vidas)
	PersonagemGlobal.connect("pegouMoeda",self, "_on_pegouMoeda")
	PersonagemGlobal.connect("perdeuVida",self, "_on_perdeuVida")
