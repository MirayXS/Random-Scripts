<table> Module {
    <table> Data {
        <string> ServerName,
        <string> ServerIcon,
        <string> InviteCode,
    },
    <table> Config {
        <string> Filename,
    },
    <table> Connections {
        <RBXScriptSignal> Join,
        <RBXScriptSignal> NoThanks,
    },  
    <table> Tween {
        <table> Durations {
            <int> Popup,
            <int> Fade,
        },
        <Enum.EasingStyle> Style,
    },
    <boolean> IsPrompting,
}

----------

<function> Module.Prompt(<table> {
    <string> ServerName, -- [Required]
    <string> ServerIcon, -- [Optional]
    <string> InviteCode, -- [Required]
}),
--  [*] Prompts an invitation if not already prompting.

----------

<function> Module.Select(<boolean> yesNo),
--  [*] Select the option to accept or ignore the invitation.

----------

<function> Module.JoinServer(<string> inviteCode),
--  [*] Joins server without Roblox prompt, will still prompt on their Discord client.

----------

<function> Module.HidePrompt(),
--  [*] Instantaneously hides the prompt, if one is prompting.

----------

<function> Module.GetCodeFromInvite(<string> invite),
--  [*] Returns the invite code of invite.

----------

<function> Module.GetConfig(),
--  [*] Returns the entire config.

----------

<function> Module.GetInviteData(<string> inviteCode),
--  [*] Only returns the config attached to the invite code.
}

--------------------------------------------------

return Module
