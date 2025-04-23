local f = CreateFrame("Frame")

f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("TIME_PLAYED_MSG")
f:RegisterEvent("PLAYER_LOGOUT")

f:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        RequestTimePlayed() -- Fires a TIME_PLAYED_EVENT when completed

        self.startTimestamp = date("%Y-%m-%d")

    elseif event == "TIME_PLAYED_MSG" then
        local totalPlayedTime = ... -- desconstructs the totalPlayedTime from the event handler's spread arguments
        self.totalPlayedTime = totalPlayedTime
        self.startTime = GetTime()

    elseif event == "PLAYER_LOGOUT" then
        local name = UnitName("player")
        local sessionDuration = GetTime() - self.startTime
        local playedTime = self.totalPlayedTime + sessionDuration

        MyPlayedTrackerDB = MyPlayedTrackerDB or {}
        MyPlayedTrackerDB[name] = MyPlayedTrackerDB[name] or {}
        MyPlayedTrackerDB[name][self.startTimestamp] = playedTime
    end
end)
