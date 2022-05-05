require "go.ui.Scene"
require "SnakeProtocol"

class 'RevLogo' (Scene)

function RevLogo:__init(id)	super(id)
	self:SetupUIObjects()

	self:SetMsgHandler(Evt_KeyboardDown, self.OnKeyDown)
end

function RevLogo:OnKeyDown(msg)
	local keyValue = msg:GetValue(Evt_KeyboardDown.key.Value)
	print(keyValue)

	if keyValue == UIConst.KeyEscape then
		gameapp:ChangeGameWindow("title")
	end
end

function RevLogo:Update(elapsed)
	gameapp.logo_snd:PlaySound(false)
	WaitSec(3)
	gameapp.logo_snd:StopSound()
	gameapp:ChangeGameWindow("title")	
end

require "RevLogoUIObject"