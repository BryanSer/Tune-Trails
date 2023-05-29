function drawing(after) {
	pushDrawState()
	after()
	popDrawState()
}
global.drawStateStack = ds_stack_create()
function pushDrawState(){
	var state = {
		font: draw_get_font(),
		alpha: draw_get_alpha(),
		color: draw_get_color(),
		halign: draw_get_halign(),
		lighting: draw_get_lighting(),
		valign: draw_get_valign()
	}
	ds_stack_push(global.drawStateStack, state)
}
function popDrawState(){
	var state = ds_stack_pop(global.drawStateStack)
	if(is_struct(state)){
		draw_set_alpha(state.alpha)
		draw_set_font(state.font)
		draw_set_color(state.color)
		draw_set_halign(state.halign)
		draw_set_lighting(state.lighting)
		draw_set_valign(state.valign)
	}
}