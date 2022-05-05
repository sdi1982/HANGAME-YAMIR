require "go.ui.Scene"
require "SnakeProtocol"

class 'Credit' (Scene)

function Credit:__init(id)	super(id)
	self:SetupUIObjects()

	self:SetMsgHandler(Evt_KeyboardDown, self.OnKeyDown)
	self.goto_room_btn.MouseLClick:AddHandler(self, self.Ongoto_room_btnMouseLClick)
end

function Credit:OnKeyDown(msg)
	local keyValue = msg:GetNValue(Evt_KeyboardDown.key.Value)
	print(keyValue)
end

function Credit:Update(elapsed)

end

function Credit:Ongoto_room_btnMouseLClick(sender, msg)
	-- Add event hanlder code here
	gameapp:ChangeGameWindow("game_room")
end

require "CreditUIObject"