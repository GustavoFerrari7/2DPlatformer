extends Node


signal MudouAlavanca
signal MudouBotao
# Called when the node enters the scene tree for the first time.
func MudouAlavanca():
	emit_signal("MudouAlavanca")
	
func MudouBotao():
	emit_signal("MudouBotao")

