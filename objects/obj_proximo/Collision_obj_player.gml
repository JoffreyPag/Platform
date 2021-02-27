//checando se pode ir para a proxima room se ela existir
if(qtd <= 0){
	if(room_next(room) != -1){
		room_goto_next()
	}else{
		game_restart()
	}
}