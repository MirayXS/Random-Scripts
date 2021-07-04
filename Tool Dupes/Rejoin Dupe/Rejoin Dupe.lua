--[[
     _____      _       _         _____                   
    |  __ \    (_)     (_)       |  __ \                  
    | |__) |___ _  ___  _ _ __   | |  | |_   _ _ __   ___ 
    |  _  // _ \ |/ _ \| | '_ \  | |  | | | | | '_ \ / _ \
    | | \ \  __/ | (_) | | | | | | |__| | |_| | |_) |  __/
    |_|  \_\___| |\___/|_|_| |_| |_____/ \__,_| .__/ \___|
              _/ |                            | |         
             |__/                             |_|         
    
    Rejoin Dupe v1.0.0a

    Scripting - Vynixu

    [ What's new? ]

    [+] Initial release

]]--

getgenv().RejoinDupe = function(amount)
    writefile("RD_Config.json", game.HttpService:JSONEncode({Amount = amount, Current = 0}))
    loadstring(readfile("RD_Script.lua"))()
end

writefile("RD_Script.lua", game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Random-Scripts/main/Tool%20Dupes/Rejoin%20Dupe/Dupe%20Script"))
getgenv().RejoinDupe(10) -- Amount to dupe
