dataAudio = {
    isAudioChannelBusy2 = audio.isChannelActive(2),
    isAudioChannelBusy3 = audio.isChannelActive(3),
    isAudioChannelBusy4 = audio.isChannelActive(4),
    isAudioChannelBusy5 = audio.isChannelActive(5),
}

function dataAudio.getIsAudioChannelBusy2()
    return audio.isChannelPlaying(2)
end

function dataAudio.setIsAudioChannelBusy2(isAudioChannelBusy2)
    dataAudio.isAudioChannelBusy2 = isAudioChannelBusy2
end

function dataAudio.getIsAudioChannelBusy3()
    return audio.isChannelPlaying(3)
end

function dataAudio.setIsAudioChannelBusy3(isAudioChannelBusy3)
    dataAudio.isAudioChannelBusy3 = isAudioChannelBusy3
end

function dataAudio.getIsAudioChannelBusy4()
    return audio.isChannelPlaying(4)
end

function dataAudio.setIsAudioChannelBusy4(isAudioChannelBusy4)
    dataAudio.isAudioChannelBusy4 = isAudioChannelBusy4
end

function dataAudio.getIsAudioChannelBusy5()
    return audio.isChannelPlaying(5)
end

return dataAudio