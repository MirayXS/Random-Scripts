--[[
                    _   _   ______ _ _             
        /\         | | (_) |  ____| (_)            
       /  \   _ __ | |_ _  | |__  | |_ _ __   __ _ 
      / /\ \ | '_ \| __| | |  __| | | | '_ \ / _` |
     / ____ \| | | | |_| | | |    | | | | | | (_| |
    /_/    \_\_| |_|\__|_| |_|    |_|_|_| |_|\__, |
                                              __/ |
                                             |___/
    Anti Fling v1.0.0a

    Scripting - Vynixu

    [ What's new? ]

    [+] Initial release

]]--

getgenv().AntiFling = game.RunService.Stepped:Connect(function()
    for i, v in next, game.Players:GetPlayers() do
        if v ~= game.Players.LocalPlayer and v.Character then
            for i, v in next, v.Character:GetChildren() do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end
end)
