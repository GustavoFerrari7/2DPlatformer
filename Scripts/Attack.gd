extends Area2D


var velocidade = Vector2()
var direcao= 1
var altura
var t = Timer.new()
# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	PersonagemGlobal.podeAtacar = false
	velocidade.x = direcao
	#velocidade.y = altura
	translate(velocidade)
	$AnimatedSprite.play("Sword")
	
func set_Attack(dir, forca):
	direcao = dir
	#altura = forca
	#print(altura)
	if dir == -1:
		$AnimatedSprite.flip_h = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimatedSprite_animation_finished():
	PersonagemGlobal.ataque()
	queue_free()
