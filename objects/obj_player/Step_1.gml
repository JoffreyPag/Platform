//checando se acabei de cair no chao
var chao_temp = place_meeting(x,y+1,obj_plat)
if(chao_temp and !chao){
	//acabei de tocar no chao
	xscale = 1.6;		
	yscale = .5;	
	
	//criando a poeira
	for(var i=0; i<irandom_range(4,10); i++){
		var xx = random_range(x-sprite_width/2, x+sprite_width)
		
		instance_create_depth(xx,y,depth-1000,obj_vel)
	}
}

//reiniciando o jogo
if(keyboard_check_pressed(vk_enter)) room_restart()
