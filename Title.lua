require "go.ui.Scene"
require "SnakeProtocol"

class 'Title' (Scene)

function Title:__init(id)	super(id)
	self:SetupUIObjects()

	self:SetMsgHandler(Evt_KeyboardDown, self.OnKeyDown)
	
end

function Title:OnKeyDown(msg)
	local keyValue = msg:GetValue(Evt_KeyboardDown.key.Value)
	print(keyValue)
	if keyValue == UIConst.KeyEscape then
		gameapp:ChangeGameWindow("game_room")
	end
end

function Title:Update(elapsed)
	gameapp.title_snd:PlaySound(false)
	WaitSec(4)
	gameapp.title_snd:StopSound()
	gameapp:ChangeGameWindow("game_room")
end

function Title:OnPlayBGM()
	gameapp.title_snd:PlaySound(false)
end

require "TitleUIObject"