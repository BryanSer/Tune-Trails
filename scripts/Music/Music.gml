enum PlayStatus {
	DESTROYED = -1,
	STOP = 0,
	PAUSE = 1,
	PLAYING = 2
}


function Music() constructor{
	audioData = pointer_null
	
	soundInstanceId = -1
	
	static loadFile = function(fileName) {
		audioData = global.audioManager.createAudioData(fileName)
		if (audioData.type == SoundType.OGG) {
			logE("不支持的格式OGG")
		}
	}
	
	static getTimeLength = function() {
		var sampleSize = audioData.channelLength * audioData.bit / 8;
		var numSamples = audioData.length / sampleSize;
		var duration = numSamples / audioData.rate / audioData.pitch;
		return duration
	}
	
	static isDestroyed = function() {
		return audioData == pointer_null || audioData.audioId < 0
	}
	
	static destroy = function() {
		global.audioManager.releaseAudio(audioData)
		soundInstanceId = -1
		audioData = pointer_null
	}
	
	static getPlayStatus = function() {
		if (isDestroyed()) {
			return PlayStatus.DESTROYED
		}
		if (soundInstanceId == -1) {
			return PlayStatus.STOP
		}
		if (audio_is_playing(soundInstanceId)) {
			return PlayStatus.PLAYING
		}
		if (audio_is_paused(soundInstanceId)) {
			return PlayStatus.PAUSE
		}
		return PlayStatus.STOP
	}
	
	static play = function(at = 0) {
		if (isDestroyed()) {
			logE("该音频已经被释放")
		}
		if (soundInstanceId != -1 && audio_is_playing(soundInstanceId)) {
			logE("已经在播放中了")
		}
		var data = {
			sound: audioData.audioId,
			pitch: audioData.pitch,
			offset: at * audioData.pitch
		}
		soundInstanceId = audio_play_sound_ext(data)
	}
	
	static pause = function() {
		if (isDestroyed()) {
			logE("该音频已经被释放")
		}
		if (soundInstanceId == -1 || !audio_is_playing(soundInstanceId)) {
			logE("该音频还没有在播放")
		}
		audio_pause_sound(soundInstanceId)
	}
	
	static resume = function() {
		if (isDestroyed()) {
			logE("该音频已经被释放")
		}
		if (soundInstanceId == -1) {
			logE("该音频还没有在播放")
		}
		if(!audio_is_paused(soundInstanceId)) {
			logE("该音频还没有被暂停")
		} 
		audio_resume_sound(soundInstanceId)
	}
	
	static stop = function() {
		if (isDestroyed()) {
			logE("该音频已经被释放")
		}
		if (soundInstanceId == -1 || !audio_is_playing(soundInstanceId)) {
			logE("该音频还没有在播放")
		}
		audio_stop_sound(soundInstanceId)
	}
	
	static seek = function(to, isOffset = false) {
		if (isDestroyed()) {
			logE("该音频已经被释放")
		}
		if (soundInstanceId == -1) {
			logE("该音频还没有在播放")
		}
		var current = audio_sound_get_track_position(soundInstanceId) / audioData.pitch
		stop()
		var at = to
		if (isOffset) {
			at += current
		}
		play(at)
	}
	
	static getCurrentTime = function() {
		if (isDestroyed()) {
			logE("该音频已经被释放")
		}
		return audio_sound_get_track_position(soundInstanceId) / audioData.pitch
	}

}