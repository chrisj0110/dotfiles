-- Hotkey: Option + 5
local lastTeamsWin = nil

hs.hotkey.bind({"alt"}, "5", function()
    local teams = hs.application.get("Microsoft Teams")
    if not teams then
        hs.application.launchOrFocus("Microsoft Teams")
        return
    end

    local wins = hs.window.filter.new("Microsoft Teams"):getWindows()
    if #wins == 0 then
        hs.application.launchOrFocus("Microsoft Teams")
        return
    end

    -- Sort windows by size (largest = meeting, smaller = main chat)
    table.sort(wins, function(a, b)
        return a:frame().w * a:frame().h > b:frame().w * b:frame().h
    end)

    local meetingWin = wins[1]                 -- biggest = meeting
    local chatWin    = (#wins > 1) and wins[#wins] or nil -- smallest = chat

    local current = hs.window.focusedWindow()

    if chatWin and current == meetingWin then
        chatWin:focus()
        lastTeamsWin = meetingWin
    elseif chatWin and current == chatWin then
        meetingWin:focus()
        lastTeamsWin = chatWin
    elseif chatWin and lastTeamsWin == meetingWin then
        chatWin:focus()
        lastTeamsWin = meetingWin
    elseif chatWin then
        meetingWin:focus()
        lastTeamsWin = chatWin
    else
        meetingWin:focus()
    end
end)

