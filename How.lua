require "go.ui.Scene"
require "SnakeProtocol"

class 'How' (Scene)

function How:__init(id)	super(id)
	self:SetupUIObjects()

	--self:SetMsgHandler(Evt_KeyboardDown, self.OnKeyDown)
	self.btn1.MouseLClick:AddHandler(self, self.Onbtn1MouseLClick)
end

function How:OnKeyDown(msg)
	--local keyValue = msg:GetNValue(Evt_KeyboardDown.key.Value)
	--print(keyValue)
end

function How:Update(elapsed)

end

function How:Onbtn1MouseLClick(sender, msg)
	-- Add event hanlder code here
	gameapp:ChangeGameWindow("game_room")	
end
require "HowUIObject"