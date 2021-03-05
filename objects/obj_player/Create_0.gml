/// @description Insert description here
// You can write your code in this editor
grav = .3
acel_chao = .1
acel_ar = .2
acel = acel_chao
deslize = 2

//------- velocidade



//-------Limite das velocidades
max_velh = 6
max_velv = 8
len = 10

//--------- variaveis de controle
chao = false
parede_dir = false
parede_esq = false
yscale = 1
xscale = 1
dura = room_speed/4
dir = 0
carga = 1
ultima_parede = 0
ver = 1
criar_pedaco = true
iniciado = true

//controlando cor
sat = 255

//bonus para o pulo
limite_pulo = 6
timer_pulo = 0

limite_buffer = 6
timer_queda = 0
buffer_pulo = false

limite_parede = 6
timer_parede = 0

//--------- state machine
enum estados{
	parado,
	movendo,
	dash,
	morte,
	voltar
}

estado = estados.movendo

lista = noone

//-----criando a camera
if(!instance_exists(obj_camera)){
	instance_create_layer(x,y,"camera",obj_camera)
}
