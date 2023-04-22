Config = {}

Config.FrameWork           = "ESX" -- Only support => QBCORE(qb-core) and ESX
Config.getSharedObject = "esx:getSharedObject"
Config.qb_Core = "qb-core"

---- (Command) ----
Config.CommandName = "salert" -- /Config.CommandName => /odashcam
Config.alertTime   = 7000 -- 1000 sec
Config.alertVolume = 0.4 -- 0.0-1.0

---- (Allowed Jobs and Allowed Grade, on duty check) ----
Config.checkOnDuty = true -- Only support in QBCORE(qb-core) Setting the check on the person's On-Duty when using the command.
Config.allowedJobsData = { -- Jobs and Grade - Setting the allowable jobs and ranks for using the dashcam.
    police     = { title = "S.W.A.T. Alert",   img = "img/police.png",     grade = 0 },
    sheriff    = { title = "S.E.B. Alert",     img = "img/sheriff.png",    grade = 0 },
    government = { title = "N.O.O.S.E. Alert", img = "img/government.png", grade = 0 }
}

---- (Notify Message Text) ----
Config.Message = {
    offDuty     = "You are not on duty",
    not_perm    = "You do not have permission to use",
    no_message  = "You did not enter anything in the message section!",
    no_division = "You are not in the appropriate division.",
    phone_off   = "Your phone is off."
}

---- (Get Phone Status) ----
Config.checkPhoneOn = false
Config.getPhoneStatus = function(player, source) -- player => PlayerData(xPlayer) / source => server check
    if source then
        -- Your Code:

    else
        -- Your Code:

    end
    -- return status(status => true/false)
end

---- (Get Division Status) ----
Config.checkDivision = false
Config.getDivisionStatus = function(player, source) -- check in server side
    if source then
        -- Your Code:

    else
        -- Your Code:

    end
    -- return status(status => true(in division or on division)/false)
end