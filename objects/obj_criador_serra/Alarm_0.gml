var xx = (x - sprite_xoffset) + sprite_width/2
var yy = (y - sprite_yoffset) + sprite_height/2
var serra = instance_create_layer(xx, yy, "serras", obj_serra)
serra.dir = dir
serra.estado = "avanca"
serra.limite = 30000
serra.vel = vel
serra.rot = rot
serra.pai = self
serra.image_xscale = .2
serra.image_yscale = .2

alarm[0] = room_speed * alarme