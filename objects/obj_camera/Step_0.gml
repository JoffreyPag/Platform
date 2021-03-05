/// @description Insert description here
// You can write your code in this editor
if(instance_exists(obj_player)){
	alvo = obj_player
}
//else if(instance_exists(obj_pedaco)){
//	alvo = instance_nearest(obj_pedaco)
//}
else{
	alvo = self
}

x = lerp(x, alvo.x, .1)
y = lerp(y, alvo.y, .1)

//configurando o listener
audio_listener_position(x,y,0)

if(instance_exists(obj_player)){
	audio_listener_velocity(abs(obj_player.velh), abs(obj_player.velv),0)
}
if(keyboard_check_pressed(vk_enter)) room_restart()