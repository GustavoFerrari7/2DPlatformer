extends KinematicBody2D


var movimento = Vector2(0, 0)
const aceleracao = 9
const velocidadeMaxima = 64
const gravidade = 9
const puloForca = 275
const friccao = 5
var x_input = 0
var inercia = 10
var pushanim = true
onready var sprite = $AnimatedSprite
var ATTACK = preload("res://Cenas/Attack.tscn")

func _physics_process(delta):
	#Detecta se colidiu com sprites
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var danger = get_parent().get_node("Spikes")
		if collision.collider == danger:
			bounce_spike(x_input)
			PersonagemGlobal.PerderVida()
	#Movimento para direita
	if Input.is_action_pressed("ui_right"):
		x_input = 1
		movimento.x += aceleracao*delta*60
		movimento.x = clamp(movimento.x, -velocidadeMaxima, velocidadeMaxima)
		#print(movimento.x)
		sprite.flip_h = false
		sprite.play("Run")
		if !$SoundWalk.playing and is_on_floor():
			$SoundWalk.play()
		if sign($Position2D.position.x) == -1:
			$Position2D.position.x *= -1
		
	#Movimento para esquerda
	elif Input.is_action_pressed("ui_left"):
		x_input = -1
		movimento.x += -aceleracao*delta*60
		movimento.x = clamp(movimento.x, -velocidadeMaxima, velocidadeMaxima)
		sprite.flip_h = true
		sprite.play("Run")
		if !$SoundWalk.playing and is_on_floor():
			$SoundWalk.play()
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
	#Parado
	else:
			x_input = 0
			sprite.play("Idle")
	#Ataque
	if Input.is_action_just_pressed("Attack") and PersonagemGlobal.podeAtacar:
		var Attack = ATTACK.instance()
		if sign($Position2D.position.x) == 1:
			Attack.set_Attack(1,movimento.y)
		else:
			Attack.set_Attack(-1,movimento.y)
		get_parent().add_child(Attack)
		$SoundSword.play()
		Attack.position =$Position2D.global_position

		
	#Redução de velocidade de movimento
	if is_on_floor():
		if x_input == 0:
			movimento.x = lerp(movimento.x, 0, friccao * delta)
		if Input.is_action_pressed("jump") and not Input.is_action_pressed("ui_down"):
			movimento.y = -puloForca
			$SoundJump.play()
		elif Input.is_action_pressed("jump") and  Input.is_action_pressed("ui_down"):
			self.position = Vector2(self.position.x, self.position.y + 1)
	#Ação de pulo

	#Resistencia do ar
	if not is_on_floor():
		if (x_input == 0):
			movimento.x = lerp(movimento.x,0,2*delta)
		sprite.play("Jump")	
	#animação de queda
		if (movimento.y > 0):
			sprite.play("Fall")
		
		
	#Força do pulo conforme o quão apertado o botão é
	if Input.is_action_just_released("jump") and movimento.y < -puloForca/2:
		movimento.y = -puloForca/2
	
	if Input.is_action_just_pressed("Reset"):
		PersonagemGlobal.resetarP()
		self.set_position(Checkpoint.ultimaPosicao)

	#Gravidade
	movimento.y = movimento.y + gravidade*delta*60
	
	#função de movimento
	movimento = move_and_slide(movimento,Vector2.UP,false,4,PI/4,false)
	
	#Movimentar Pedra
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("Pedras"):
			collision.collider.apply_impulse(Vector2(0,4), (-collision.normal * inercia))
			if !$SoundEmpurrar.playing:
				$SoundEmpurrar.play()

	#Personagem quando é atingido por inimigo, desabilitar colisão mudar cor e ligar timer
func take_damage():
	$SoundDamage.play()
	set_collision_layer_bit(0,false)
	set_collision_mask_bit(4, false)
	set_collision_mask_bit(6, false)
	set_modulate(Color(1,0.3,0.3,0.3))
	$Timer.start()

	#pulo em cima do cogumelo
func bounce_mushroom():
	movimento.y = -puloForca * 1.3

	#Bounce quando toka em espinhos
func bounce_spike(pos):
	take_damage()
	movimento.y = -puloForca * 0.5
	if pos == 1:
		movimento.x = -100
	elif pos == -1:
		movimento.x = 100
	
	#Bounce quando é tocado por outros inimigos
func bounce_enemies(posinimigo):
	take_damage()
	movimento.y = -puloForca * 0.5
	if position.x < posinimigo:
		movimento.x = -100
	elif position.x > posinimigo:
		movimento.x = 100

	#Reseta posição quando entra na fallzone
func _on_QuedaForaMapa_body_entered(body):
	PersonagemGlobal.PerderVida()
	$SoundDamage.play()
	self.set_position(Checkpoint.ultimaPosicao)
	

	#aciona quando o timer acaba
func _on_Timer_timeout():
	set_collision_layer_bit(0,true)
	set_collision_mask_bit(4, true)
	set_collision_mask_bit(6, true)
	set_modulate(Color(1, 1, 1,1)) # reseta cor
