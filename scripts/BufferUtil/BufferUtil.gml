function BufferUtil(){
	return {
		peekString: function(buffer, offset, length){
			var at = offset
			var str = ""
			for(var i = 0; i < length; i++) {
				var val = buffer_peek(buffer, offset + i, buffer_u8)
				try {
					var char = chr(val & 255)
					str += char
				}catch(e){}
			}
			return str
		},
		peekInt: function(buffer, offset) {
			return buffer_peek(buffer, offset, buffer_s32)
		},
		peekUInt:  function(buffer, offset) {
			return buffer_peek(buffer, offset, buffer_u32)
		},
		peekLong: function(buffer, offset) {
			return buffer_peek(buffer, offset, buffer_u64)
		},
		peekShort: function(buffer, offset) {
			return buffer_peek(buffer, offset, buffer_s16)
		},
		peekUShort: function(buffer, offset) {
			return buffer_peek(buffer, offset, buffer_u16)
		},
		peekByte: function(buffer, offset) {
			return buffer_peek(buffer, offset, buffer_s8)
		},
		peekUByte: function(buffer, offset) {
			return buffer_peek(buffer, offset, buffer_u8)
		},
		peekFloat: function(buffer, offset) {
			return buffer_peek(buffer, offset, buffer_f32)
		},
		peekDouble: function(buffer, offset) {
			return buffer_peek(buffer, offset, buffer_f64)
		},
		loadFileToFixbuffer: function(fileName) {
			var buffer_file = buffer_load(fileName);
			var size = buffer_get_size(buffer_file);
			var buffer = buffer_create(size, buffer_fixed, 1);
			buffer_copy(buffer_file, 0, size, buffer, 0);
			return buffer
		}
		
	}
}

global.bufferUtil = BufferUtil()