/// @description Insert description here
// You can write your code in this editor
var currentHash = textViewHash(self)
if((currentHash != lastHash || !surface_exists(textSruface)) || textSruface == undefined) {
	if(textSruface != undefined && surface_exists(textSruface)){
		surface_free(textSruface)
	}
	lastHash = currentHash
	var drawView = self
	drawing(
		method({view:drawView}, function(){
			with(view){
				draw_set_font(font)
				var currentDrawLine = 0
				var _lines = string_split(text, "\n")
				var lines = ds_list_create()
				forEach(_lines,method({list:lines}, function(item){
					ds_list_add(list, item)
				}))
				var drawW = 0,drawH = 0,auotW = false, autoH = false
				var currentH = 0
				if(width == AUTO_WARP){
					auotW = true
				}else{
					drawW = width
				}
				if(height == AUTO_WARP){
					autoH = true
				}else{
					drawH = height
				}
				var drawText = ds_list_create()
				var drawHList = ds_list_create()
				//预检查文本是否符合规则
				for(var line = 0; line < ds_list_size(lines); line++){
					var content = lines[| line] 
					var w = string_width(content)
					if(auotW){
						drawW = max(drawW, w)
						if(drawW > maxWidth && maxWidth != MAX_UNLIMIT){
							drawW = maxWidth
						}
					}
					if(w > drawW){
						var count = string_length(content)
						var tw = w
						while(tw > drawW && count > 0){
							var subStr = string_copy(content, 0, --count)
							tw = string_width(subStr)
						}
						var textToNextLine = string_copy(content, count, string_length(content) - count)
						content = string_copy(content, 0, count)
						if(line + 1 >= ds_list_size(lines)){
							ds_list_add(lines, textToNextLine)
						} else {
							ds_list_insert(lines, line + 1, textToNextLine)
						}
					}
					var h = string_height(content)
					currentH += h
					if(autoH) {
						if(currentH > maxHeight && maxHeight != MAX_UNLIMIT){
							logD("文本过高, {0}, {1}", id,text)
							break
						}
						drawH = currentH
					} else {
						if(currentH > drawH){
							logD("文本过高, {0}, {1}", id, text)
							break
						}
					}
					ds_list_add(drawText, content)
					ds_list_add(drawHList, h)
				}
				//绘制文本
				var realW = drawW + margin[MarginIndex.START] + margin[MarginIndex.END]
				var realH = drawH + margin[MarginIndex.TOP] + margin[MarginIndex.BOTTOM]
				var surface = surface_create(realW, realH)
				surface_set_target(surface)
				draw_clear_alpha(background, backgroundAlpha)
				draw_set_color(stokeColor)
				draw_set_alpha(stokeColorAlpha)
				var lt = new Vector(1,1), br =new Vector(realW - 2, realH - 2)
				repeat(stokeWidth){
					draw_rectangle(lt.x,lt.y, br.x, br.y, true)
					lt.add(new Vector(1, 1))
					br.add(new Vector(-1, -1))
				}
				var drawAt = new Vector(margin[MarginIndex.START], margin[MarginIndex.TOP])
				var drawLine = ds_list_size(drawText)
				if(maxLine != MAX_UNLIMIT && drawLine > maxLine){
					drawLine = maxLine
				}
				for(var i = 0; i < drawLine; i++){
					draw_text(drawAt.x, drawAt.y, drawText[| i])
					drawAt.y += drawHList[| i]
				}
				surface_reset_target()
				textSruface = surface
				ds_list_destroy(lines)
				ds_list_destroy(drawText)
				ds_list_destroy(drawHList)
			}
		})
	)
}