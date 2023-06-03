
enum SoundType {
	OGG = 0,
	WAV = 1
}
function initAudioManager() {

	var getDataStart = function (buffer) {
		var chunkNameIndex = 12
		while (true) {
			var name = string_upper(global.bufferUtil.peekString(buffer, chunkNameIndex, 4))
			if (name == "DATA") {
				return chunkNameIndex
			}
			var size = global.bufferUtil.peekInt(buffer, chunkNameIndex + 4)
			chunkNameIndex += size
			chunkNameIndex += 8
		}
	}

	var loadFile = method({ getDataStart: getDataStart },
		function (fileName) {
			var buffer = global.bufferUtil.loadFileToFixbuffer(fileName)
			var soundInfo = {
				buffer: buffer,
				audioId: -1,
				type: undefined,
				channelLength: 0,
				channel: undefined,
				bit: 0,
				rate: 0,
				pitch: 1,
				bitBufferType: undefined,
				length: 0,
				offset: 0
			}
			var ogg = string_upper(global.bufferUtil.peekString(buffer, 0, 4))
			if (ogg == "OGGS") {
				soundInfo.type = SoundType.OGG
				soundInfo.audioId = audio_create_stream(fileName)
				return soundInfo
			} else {
				var wav = string_upper(global.bufferUtil.peekString(buffer, 8, 4))
				if (wav == "WAVE") {
					soundInfo.type = SoundType.WAV
				} else {
					logE("不支持的格式, 音频仅支持OGG与WAV")
				}
			}
			soundInfo.channelLength = global.bufferUtil.peekShort(buffer, 22)
			soundInfo.rate = global.bufferUtil.peekInt(buffer, 24)
			soundInfo.bit = global.bufferUtil.peekShort(buffer, 34)
			if (soundInfo.rate > 48000) {
				soundInfo.pitch = (soundInfo.rate / 48000)
				soundInfo.rate = 48000
			}
			switch (soundInfo.channelLength) {
				case 1:
					soundInfo.channel = audio_mono
					break
				case 2:
					soundInfo.channel = audio_stereo
					break
				case 6:
					soundInfo.channel = audio_3D
					break
				default:
					logE("未知的channel数量")
					break
			}
			var dataIndex = getDataStart(buffer)
			var dataSize = global.bufferUtil.peekInt(buffer, dataIndex + 4)
			var length = dataSize

			if (soundInfo.bit == 8) {
				soundInfo.bitBufferType = buffer_u8
			} else if (soundInfo.bit == 16) {
				soundInfo.bitBufferType = buffer_s16
			} else {
				logE("不支持的bit数")
			}
			soundInfo.length = length
			soundInfo.offset = dataIndex + 8
			soundInfo.audioId = audio_create_buffer_sound(
				buffer,
				soundInfo.bitBufferType,
				soundInfo.rate,
				soundInfo.offset,
				length,
				soundInfo.channel
			)
			return soundInfo
		})


	return {
		createAudioData: method({ loadFile: loadFile }, function (fileName) {
			return loadFile(fileName)
		}),
		releaseAudio: function(audioData) {
			audio_stop_sound(audio.audioId)
			audio_destroy_stream(audioData.audioId)
			audioData.audioId = -1
		},
		playAudio: method({ loadFile: loadFile }, function (fileName) {
			var audio = loadFile(fileName)

			audio_play_sound_ext({
				sound: audio.audioId,
				pitch: audio.pitch
			})
		})
	}

}

global.audioManager = initAudioManager()