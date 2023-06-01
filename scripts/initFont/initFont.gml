#macro DEFAULT_FONT "ark-pixel-12px-monospaced-zh_cn.ttf"

function initFont() {
	logD("initFont")
    var _fontCache = {};  

    var __loadFont = method(
		{_fontCache: _fontCache},
		function(name, size, bold = 0, italic = 0) {
			var cacheKey = string("n{3}s{0}b{1}i{2}", size, bold, italic, name);
			var cache = _fontCache[$ cacheKey];
			if (cache != undefined) {
			    return cache;
			}
			var font = font_add(name, size, bold, italic, 0, 65533);
			_fontCache[$ cacheKey] = font;
			return font;
		}
	)

    return {
        loadFont: method(
			{__loadFont: __loadFont},
			function(size, bold = 0, italic = 0) {
				return __loadFont(DEFAULT_FONT, size, bold, italic);
			}
		),
        getFontInfo: function(font) {
            return {
                font: font,
                size: font_get_size(font),
                bold: font_get_bold(font),
                italic: font_get_italic(font)
            };
        }
    };
}

global.fontManager = initFont();  // 初始化字体管理器
