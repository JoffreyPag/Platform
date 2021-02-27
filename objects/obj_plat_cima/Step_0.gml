/// @description Insert description here
// You can write your code in this editor
if(instance_exists(obj_player)){
	if(obj_player.y > y+(sprite_height/2))//a plataforma esta acima do player
	{
		sprite_index = -1
	}else{
		sprite_index = spr_plat_cima
	}
}