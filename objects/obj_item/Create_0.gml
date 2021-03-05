/// @description Insert description here
// You can write your code in this editor
eu = audio_emitter_create();
audio_emitter_position(eu, x,y,0)
audio_emitter_falloff(eu, 100, 300, 1)
audio_falloff_set_model(audio_falloff_exponent_distance)
audio_play_sound_on(eu, Sound1, true, 5)