/// @description Insert description here
// You can write your code in this editor

//rodando
image_angle += rot
switch(estado){
	case "avanca":
		//descobrindo a direção do limite
		var limite_x = lengthdir_x(limite, dir)
		var limite_y = lengthdir_y(limite, dir)
		
		//movendo
		x+= lengthdir_x(vel, dir)
		y+=lengthdir_y(vel, dir)
		
		//trocando o estado
		if(limite_x > 0)//tenho que ir pra a direita
		{
			if(x>=xstart+limite_x) estado = "recua"
		}else if(limite_x< 0){
			//tem que ir para a esquerda
			if(x<=xstart+limite_x) estado = "recua"
		}
		
		if(limite_y > 0)//tenho que ir pra a direita
		{
			if(y>=ystart+limite_y) estado = "recua"
		}else if(limite_y< 0){
			//tem que ir para a esquerda
			if(y<=ystart+limite_y) estado = "recua"
		}
		
	break;
	case "recua":
		//movendo
		x -= lengthdir_x(vel, dir)
		y -= lengthdir_y(vel, dir)
		
		//mudando de estado
		if(x == xstart and y == ystart) estado = "avanca"
		
	break;
	case "parado":
	
	break;
	default:
		show_message("voce digitou o nome do estado errado!!!!")
}