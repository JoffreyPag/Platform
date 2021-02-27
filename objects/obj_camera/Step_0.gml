/// @description Insert description here
// You can write your code in this editor
if(instance_exists(obj_player)){
	x = lerp(x, obj_player.x, .1)
	y = lerp(y, obj_player.y, .1)
}