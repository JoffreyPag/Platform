//checando se esta tocando no chao
chao = place_meeting(x,y+1,obj_plat )
//checando se esta tocando na parede
parede_dir = place_meeting(x+1,y,obj_plat )
parede_esq = place_meeting(x-1,y,obj_plat )

//configurando o timer do pulo
if(chao){
	timer_pulo = limite_pulo
}else{
	if(timer_pulo > 0) timer_pulo --
}

if(parede_dir or parede_esq){
	if(parede_dir) ultima_parede = 0;
	else ultima_parede = 1;
	
	timer_parede = limite_parede
	
}else{
	if(timer_parede > 0) timer_parede --
}

//--------------- controles
#region controles
var left, right, up, down, jump, jump_s, mov_h,dash;

left = keyboard_check(ord("A"))
right = keyboard_check(ord("D"))
up = keyboard_check(ord("W"))
down= keyboard_check(ord("S"))
jump = keyboard_check_pressed(vk_space)
jump_s = keyboard_check_released(vk_space)
dash = keyboard_check_pressed(ord("L"))

//configrando informacoes da movimentacao
mov_h = (right-left)*max_velh

//valor da aceleracao
if(chao){
	acel = acel_chao
	carga = 1
}
else{
	acel = acel_ar
}
#endregion

//------------------- STATE MACHINE
switch(estado){
	#region parado
	case estados.parado:
		velh = 0
		velv = 0
		
		//pode mudar a velocidade
		//pulando
		if(!chao) velv += grav
		if(chao and jump){
			velv = -max_velv
			
			//alterando a escala
			xscale = .5
			yscale = 1.5
			
			for(var i=0; i<irandom_range(4,10); i++){
						
				var xx = random_range(x - sprite_width/2, x+sprite_width/2)
		
				instance_create_layer(xx,y,"particulas",obj_vel)
			}
		}
		
		//saindo do estado
		if(abs(velh) > 0 or abs(velv) > 0 or left or right or jump) estado = estados.movendo
		
		//dash
		if(dash and carga > 0){ if(right or up or left or down){
				dir = point_direction(0,0,(right-left), (down-up))
			}else{
				//dando dash para a direçao que ta olhando
				dir = point_direction(0,0,ver, 0)
			}
			estado = estados.dash;
			carga--
		}
	break;
	#endregion
	
	#region movendo
	case estados.movendo:
	
		//abaixando
		if(chao and down){
			xscale = 1.5
			yscale = .5
		}
	
	
		//aplicando velocidade horizontal
		velh = lerp(velh, mov_h, acel)

		//fazendo poeira
		if(abs(velh) > max_velh -.5 and chao){
			var chance = random(100)
			if(chance > 95){
				for(var i=0; i<irandom_range(4,10); i++){
					var xx = random_range(x-sprite_width/2, x+sprite_width/2)
		
					instance_create_layer(xx,y,"particulas",obj_vel)
				}
			}
		}
		
		//gravidade e parede
		if(!chao and (parede_dir or parede_esq or timer_parede)){
			//nao esta no chao, mas esta na parede
			if(velv > 0){
			//esta na parede e esta caindo
				velv = lerp(velv, deslize, acel)
				//fazendo poeira
				var chance = random(100)
				if(chance > 90){
					for(var i=0; i<irandom_range(4,10); i++){
						var onde = parede_dir - parede_esq
						
						//var xx = random_range(x-sprite_width/2, x+sprite_width/2)
						var xx = x+onde*sprite_width/2
						var yy = y + random_range(-sprite_height, 0)
		
						instance_create_layer(xx,y,"particulas",obj_vel)
					}
				}
				
			}else{
				//esta subindo
				velv += grav
			}
			//pulando pelas paredes
			if(!ultima_parede and jump){
			//esta na parede e tentou pular
				velv = -max_velv
				velh = -max_velh
				xscale = .5
				yscale = .5
				
				for(var i=0; i<irandom_range(4,10); i++){
						
					//var xx = random_range(x-sprite_width/2, x+sprite_width/2)
					var xx = x + sprite_width/2
					var yy = y + random_range(-sprite_height, 0)
		
					instance_create_layer(xx,yy,"particulas",obj_vel)
				}
				
			}else if(ultima_parede and jump){
				velv = -max_velv
				velh = max_velh
				xscale = .5
				yscale = .5
				
				for(var i=0; i<irandom_range(4,10); i++){
						
					//var xx = random_range(x-sprite_width/2, x+sprite_width/2)
					var xx = x - sprite_width/2
					var yy = y + random_range(-sprite_height, 0)
		
					instance_create_layer(xx,yy,"particulas",obj_vel)
				}
			}
		}else if(!chao){
			//nao esta no chao mas nao esta na parede
			velv += grav
		}
		
		//pulo
		if((chao or timer_pulo) and jump){
			velv = -max_velv
			
			//alterando a escala
			xscale = .5
			yscale = 1.5
			
			for(var i=0; i<irandom_range(4,10); i++){
						
					var xx = random_range(x - sprite_width/2, x+sprite_width/2)
		
					instance_create_layer(xx,y,"particulas",obj_vel)
				}
		}
		
		//buffer do pulo
		if(jump){
			timer_queda = limite_buffer
		}
		if(timer_queda > 0) buffer_pulo = true
		else buffer_pulo = false
		
		if(buffer_pulo){
		//pode pular
			if(chao or timer_pulo){
				//as demais condicoes para o pulo sao verdadeiras tbm
				velv = -max_velv
				xscale = .5
				yscale = 1.5
				
				timer_pulo = 0
				timer_queda = 0
			}
			timer_queda--
		}
		
		//controlando a altura do pulo
		//quando o botao de pulo for solto e a velocidade for negativa (personagem esta subindo) a velocidade começa a ser atenuada
		if(jump_s and velv < 0) velv*= .7
		
		//dash
		
			
		//saindo do estado
		if(velh == 0 and velv == 0 and !left and !right and !jump) estado = estados.parado
		//dash
		if(dash and carga > 0){ 
			
			dir = point_direction(0,0,(right-left), (down-up))
			
			estado = estados.dash;
			carga--
		}
		//limitando as velocidades
		velv = clamp(velv, -max_velv, max_velv)
	break;
	#endregion
	
	#region dash
	case estados.dash:
		dura--
		
		velh = lengthdir_x(len, dir)
		velv = lengthdir_y(len, dir)
		
		//deformando o player
		if(dir == 90 or dir == 270){
			yscale = 1.5
			xscale = .5
		}else{
			yscale = .5
			xscale = 1.5
		}
		
		//criando o rastro
		var rastro = instance_create_layer(x,y, "Player_rastro", obj_vestigio)
		rastro.xscale = xscale
		rastro.yscale = yscale
		
		//saindo do estado
		if(dura <= 0){
			estado = estados.movendo
			dura = room_speed/4	
			
			//diminuindo a velocidade
			velh = (max_velh * sign(velh) * .5)
			velv = (max_velv * sign(velv) * .5)
		}
		
	break;
	#endregion
	
	#region morte
	case estados.morte:
		//explodindo o player
		if(criar_pedaco){
			for(var i=0; i<10; i++){
				var p = instance_create_layer(x,y, layer, obj_pedaco)
				p.speed = random_range(1,2)
				p.direction = random(360)
				p.image_angle = p.direction
				p.image_xscale = random_range(.2,.6)
				p.image_yscale = p.image_xscale
				p.image_blend = make_color_hsv(20, sat, 255)
				p.dest_x = xstart
				p.dest_y = ystart
				p.velh_inicial = velh_inicial
				p.velv_inicial = velv_inicial
				lista[i] = p.id
				//if(i>=10) criar_pedaco = false
			}
			p.criador = true
			p.lista = lista
			criar_pedaco = false
			obj_camera.alvo = p
			instance_destroy()
		}
	break;
	#endregion
	case estados.voltar:
	break;
}

switch(carga){
	case 0:
		sat = lerp(sat, 50, .05)
	break;
	case 1:
		sat = lerp(sat, 255, .05)
	break;	
}
//defininfo a cor dele
image_blend = make_color_hsv(20, sat, 255)


//voltando para a escala original
xscale = lerp(xscale, 1, .15)
yscale = lerp(yscale, 1, .15)
