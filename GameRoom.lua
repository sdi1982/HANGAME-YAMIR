require "go.ui.Scene"
require "SnakeProtocol"
require "RGGameUser"

-- GameRoom : 게임방 클래스 
-- userCount : 현재 방에 접속해 있는 유저수 (최대4명)
-- startGame : 현재 방이 게임이 시작했는지 여부
class 'GameRoom' (Scene)

function GameRoom:__init(id)	super(id)
	self:SetupUIObjects()

	self:SetMsgHandler(Evt_KeyboardDown, self.OnKeyDown)

	self.map_btn.MouseLClick:AddHandler(self, self.Onmap_btnMouseLClick)
	self.radiobutton1.MouseLClick:AddHandler(self, self.Onradiobutton1MouseLClick)
	self.radiobutton2.MouseLClick:AddHandler(self, self.Onradiobutton2MouseLClick)
	self.radiobutton3.MouseLClick:AddHandler(self, self.Onradiobutton3MouseLClick)
	self.radiobutton4.MouseLClick:AddHandler(self, self.Onradiobutton4MouseLClick)
	self.radiobutton5.MouseLClick:AddHandler(self, self.Onradiobutton5MouseLClick)
	self.radiobutton6.MouseLClick:AddHandler(self, self.Onradiobutton6MouseLClick)
	self.radiobutton7.MouseLClick:AddHandler(self, self.Onradiobutton7MouseLClick)
	
	self.exit_btn.MouseLClick:AddHandler(self, self.Onexit_btnMouseLClick)
	self.ready_btn.MouseLClick:AddHandler(self, self.Onready_btnMouseLClick)
	self.how_btn.MouseLClick:AddHandler(self, self.OnHow_btnMouseLClick)
	self.credit_btn.MouseLClick:AddHandler(self, self.OnCredit_btnMouseLClick)

	self.snake1.MouseLClick:AddHandler(self, self.Onsnake1MouseLClick)
	self.snake2.MouseLClick:AddHandler(self, self.Onsnake2MouseLClick)
	self.snake3.MouseLClick:AddHandler(self, self.Onsnake3MouseLClick)
	self.snake4.MouseLClick:AddHandler(self, self.Onsnake4MouseLClick)
	self.snake5.MouseLClick:AddHandler(self, self.Onsnake5MouseLClick)
	self.snake6.MouseLClick:AddHandler(self, self.Onsnake6MouseLClick)
	self.snake7.MouseLClick:AddHandler(self, self.Onsnake7MouseLClick)
	self.bgm_btn.MouseLClick:AddHandler(self, self.Onbgm_btnMouseLClick)
	self.es_btn.MouseLClick:AddHandler(self, self.Ones_btnMouseLClick)
end


function GameRoom:OnKeyDown(msg)
	local keyValue = msg:GetValue(Evt_KeyboardDown.key.Value)
	if keyValue == UIConst.KeyEnter then
	end
end

function GameRoom:Update(elapsed)

end

function GameRoom:GetUserCount()
	return self.userCount;
end

function GameRoom:SetUserCount(user_count)
	self.userCount = user_count
end


function GameRoom:Onmap_btnMouseLClick(sender, msg)
	
	local msg = Message(Evt_MapSelect_Req)
	gameapp:SendToServer(msg)
end

function GameRoom:Onradiobutton1MouseLClick(sender, msg)
	self.snake1:LoadRadioButtonImage("images/GAMEROOM/snake_view_red1.png", 8, 1, nil, nil)
	self.snake2:LoadRadioButtonImage("images/GAMEROOM/snake_view_red2.png", 8, 1, nil, nil)
	self.snake3:LoadRadioButtonImage("images/GAMEROOM/snake_view_red3.png", 8, 1, nil, nil)
	self.snake4:LoadRadioButtonImage("images/GAMEROOM/snake_view_red4.png", 8, 1, nil, nil)
	self.snake5:LoadRadioButtonImage("images/GAMEROOM/snake_view_red5.png", 8, 1, nil, nil)
	self.snake6:LoadRadioButtonImage("images/GAMEROOM/snake_view_red6.png", 8, 1, nil, nil)
	self.snake7:LoadRadioButtonImage("images/GAMEROOM/snake_view_red7.png", 8, 1, nil, nil)
	local msg = Message(Evt_Color_Req)
	msg:SetValue(Evt_Color_Req.key.color,1)
	gameapp:SendToServer(msg)
end

function GameRoom:Onradiobutton2MouseLClick(sender, msg)
	self.snake1:LoadRadioButtonImage("images/GAMEROOM/snake_view_yellow1.png", 8, 1, nil, nil)
	self.snake2:LoadRadioButtonImage("images/GAMEROOM/snake_view_yellow2.png", 8, 1, nil, nil)
	self.snake3:LoadRadioButtonImage("images/GAMEROOM/snake_view_yellow3.png", 8, 1, nil, nil)
	self.snake4:LoadRadioButtonImage("images/GAMEROOM/snake_view_yellow4.png", 8, 1, nil, nil)
	self.snake5:LoadRadioButtonImage("images/GAMEROOM/snake_view_yellow5.png", 8, 1, nil, nil)
	self.snake6:LoadRadioButtonImage("images/GAMEROOM/snake_view_yellow6.png", 8, 1, nil, nil)
	self.snake7:LoadRadioButtonImage("images/GAMEROOM/snake_view_yellow7.png", 8, 1, nil, nil)
	local msg = Message(Evt_Color_Req)
	msg:SetValue(Evt_Color_Req.key.color,2)
	gameapp:SendToServer(msg)
end

function GameRoom:Onradiobutton3MouseLClick(sender, msg)
	self.snake1:LoadRadioButtonImage("images/GAMEROOM/snake_view_green1.png", 8, 1, nil, nil)
	self.snake2:LoadRadioButtonImage("images/GAMEROOM/snake_view_green2.png", 8, 1, nil, nil)
	self.snake3:LoadRadioButtonImage("images/GAMEROOM/snake_view_green3.png", 8, 1, nil, nil)
	self.snake4:LoadRadioButtonImage("images/GAMEROOM/snake_view_green4.png", 8, 1, nil, nil)
	self.snake5:LoadRadioButtonImage("images/GAMEROOM/snake_view_green5.png", 8, 1, nil, nil)
	self.snake6:LoadRadioButtonImage("images/GAMEROOM/snake_view_green6.png", 8, 1, nil, nil)
	self.snake7:LoadRadioButtonImage("images/GAMEROOM/snake_view_green7.png", 8, 1, nil, nil)
	local msg = Message(Evt_Color_Req)
	msg:SetValue(Evt_Color_Req.key.color,3)
	gameapp:SendToServer(msg)
end

function GameRoom:Onradiobutton4MouseLClick(sender, msg)
	self.snake1:LoadRadioButtonImage("images/GAMEROOM/snake_view_blue1.png", 8, 1, nil, nil)
	self.snake2:LoadRadioButtonImage("images/GAMEROOM/snake_view_blue2.png", 8, 1, nil, nil)
	self.snake3:LoadRadioButtonImage("images/GAMEROOM/snake_view_blue3.png", 8, 1, nil, nil)
	self.snake4:LoadRadioButtonImage("images/GAMEROOM/snake_view_blue4.png", 8, 1, nil, nil)
	self.snake5:LoadRadioButtonImage("images/GAMEROOM/snake_view_blue5.png", 8, 1, nil, nil)
	self.snake6:LoadRadioButtonImage("images/GAMEROOM/snake_view_blue6.png", 8, 1, nil, nil)
	self.snake7:LoadRadioButtonImage("images/GAMEROOM/snake_view_blue7.png", 8, 1, nil, nil)
	local msg = Message(Evt_Color_Req)
	msg:SetValue(Evt_Color_Req.key.color,4)
	gameapp:SendToServer(msg)
end

function GameRoom:Onradiobutton5MouseLClick(sender, msg)
	self.snake1:LoadRadioButtonImage("images/GAMEROOM/snake_view_black1.png", 8, 1, nil, nil)
	self.snake2:LoadRadioButtonImage("images/GAMEROOM/snake_view_black2.png", 8, 1, nil, nil)
	self.snake3:LoadRadioButtonImage("images/GAMEROOM/snake_view_black3.png", 8, 1, nil, nil)
	self.snake4:LoadRadioButtonImage("images/GAMEROOM/snake_view_black4.png", 8, 1, nil, nil)
	self.snake5:LoadRadioButtonImage("images/GAMEROOM/snake_view_black5.png", 8, 1, nil, nil)
	self.snake6:LoadRadioButtonImage("images/GAMEROOM/snake_view_black6.png", 8, 1, nil, nil)
	self.snake7:LoadRadioButtonImage("images/GAMEROOM/snake_view_black7.png", 8, 1, nil, nil)
	local msg = Message(Evt_Color_Req)
	msg:SetValue(Evt_Color_Req.key.color,5)
	gameapp:SendToServer(msg)
end

function GameRoom:Onradiobutton6MouseLClick(sender, msg)
	self.snake1:LoadRadioButtonImage("images/GAMEROOM/snake_view_grey1.png", 8, 1, nil, nil)
	self.snake2:LoadRadioButtonImage("images/GAMEROOM/snake_view_grey2.png", 8, 1, nil, nil)
	self.snake3:LoadRadioButtonImage("images/GAMEROOM/snake_view_grey3.png", 8, 1, nil, nil)
	self.snake4:LoadRadioButtonImage("images/GAMEROOM/snake_view_grey4.png", 8, 1, nil, nil)
	self.snake5:LoadRadioButtonImage("images/GAMEROOM/snake_view_grey5.png", 8, 1, nil, nil)
	self.snake6:LoadRadioButtonImage("images/GAMEROOM/snake_view_grey6.png", 8, 1, nil, nil)
	self.snake7:LoadRadioButtonImage("images/GAMEROOM/snake_view_grey7.png", 8, 1, nil, nil)
	local msg = Message(Evt_Color_Req)
	msg:SetValue(Evt_Color_Req.key.color,6)
	gameapp:SendToServer(msg)
end

function GameRoom:Onradiobutton7MouseLClick(sender, msg)
	self.snake1:LoadRadioButtonImage("images/GAMEROOM/snake_view_white1.png", 8, 1, nil, nil)
	self.snake2:LoadRadioButtonImage("images/GAMEROOM/snake_view_white2.png", 8, 1, nil, nil)
	self.snake3:LoadRadioButtonImage("images/GAMEROOM/snake_view_white3.png", 8, 1, nil, nil)
	self.snake4:LoadRadioButtonImage("images/GAMEROOM/snake_view_white4.png", 8, 1, nil, nil)
	self.snake5:LoadRadioButtonImage("images/GAMEROOM/snake_view_white5.png", 8, 1, nil, nil)
	self.snake6:LoadRadioButtonImage("images/GAMEROOM/snake_view_white6.png", 8, 1, nil, nil)
	self.snake7:LoadRadioButtonImage("images/GAMEROOM/snake_view_white7.png", 8, 1, nil, nil)
	local msg = Message(Evt_Color_Req)
	msg:SetValue(Evt_Color_Req.key.color,7)
	gameapp:SendToServer(msg)
end

function GameRoom:SetUserStatus()
	if gameapp.gameuser[1].exist then
		self.user_status1:Show(true)
		self.user_status1:SetStaticImageIndex(gameapp.gameuser[1].color - 1)
		self.snake_kind1:Show(true)
		self.snake_kind1:SetStaticImageIndex( (gameapp.gameuser[1].color - 1)* 7 + gameapp.gameuser[1].snakeKind - 1)
		self.user_ready1:SetStaticImageIndex(gameapp.gameuser[1].color - 1)
		self.user_level1:Show(true)
		self.user_level1:SetStaticImageIndex(gameapp.gameuser[1].level - 1)
		self.user_ready1:SetStaticImageIndex(gameapp.gameuser[1].color - 1)

		if gameapp.gameuser[1].major then
			self.user_major1:Show(true)
		else
			self.user_major1:Show(false)
		end
		if gameapp.gameuser[1].ready then
			self.user_ready1:Show(true)
		else
			self.user_ready1:Show(false)
		end


	else
		self.user_status1:Show(false)
		self.snake_kind1:Show(false)
		self.user_major1:Show(false)
		self.user_level1:Show(false)
		self.user_ready1:Show(false)
	end

	if gameapp.gameuser[2].exist then
		self.user_status2:Show(true)
		self.user_status2:SetStaticImageIndex(gameapp.gameuser[2].color - 1)
		self.snake_kind2:Show(true)
		self.snake_kind2:SetStaticImageIndex( (gameapp.gameuser[2].color - 1)* 7 + gameapp.gameuser[2].snakeKind - 1)
		self.user_ready2:SetStaticImageIndex(gameapp.gameuser[2].color - 1)
		self.user_level2:Show(true)
		self.user_level2:SetStaticImageIndex(gameapp.gameuser[2].level - 1)
		if gameapp.gameuser[2].major then
			self.user_major2:Show(true)
		else
			self.user_major2:Show(false)
		end
		if gameapp.gameuser[2].ready then
			self.user_ready2:Show(true)
		else
			self.user_ready2:Show(false)
		end

	else
		self.user_status2:Show(false)
		self.snake_kind2:Show(false)
		self.user_major2:Show(false)
		self.user_level2:Show(false)
		self.user_ready2:Show(false)
	end

	if gameapp.gameuser[3].exist then
		self.user_status3:Show(true)
		self.user_status3:SetStaticImageIndex(gameapp.gameuser[3].color - 1)		
		self.snake_kind3:Show(true)
		self.snake_kind3:SetStaticImageIndex( (gameapp.gameuser[3].color - 1)* 7 + gameapp.gameuser[3].snakeKind - 1)
		self.user_ready3:SetStaticImageIndex(gameapp.gameuser[3].color - 1)
		self.user_level3:Show(true)
		self.user_level3:SetStaticImageIndex(gameapp.gameuser[3].level - 1)

		if gameapp.gameuser[3].major then
			self.user_major3:Show(true)
		else
			self.user_major3:Show(false)
		end
		if gameapp.gameuser[3].ready then
			self.user_ready3:Show(true)
		else
			self.user_ready3:Show(false)
		end
	else
		self.user_status3:Show(false)
		self.snake_kind3:Show(false)
		self.user_major3:Show(false)
		self.user_level3:Show(false)
		self.user_ready3:Show(false)
	end

	if gameapp.gameuser[4].exist then
		self.user_status4:Show(true)
		self.user_status4:SetStaticImageIndex(gameapp.gameuser[4].color - 1)
		self.snake_kind4:Show(true)
		self.snake_kind4:SetStaticImageIndex( (gameapp.gameuser[4].color - 1)* 7 + gameapp.gameuser[4].snakeKind - 1)
		self.user_ready4:SetStaticImageIndex(gameapp.gameuser[4].color - 1)
		self.user_level4:Show(true)
		self.user_level4:SetStaticImageIndex(gameapp.gameuser[4].level - 1)

		if gameapp.gameuser[4].major then
			self.user_major4:Show(true)
		else
			self.user_major4:Show(false)
		end
		if gameapp.gameuser[4].ready then
			self.user_ready4:Show(true)
		else
			self.user_ready4:Show(false)
		end
	else
		self.user_status4:Show(false)
		self.snake_kind4:Show(false)
		self.user_ready4:Show(false)
		self.user_major4:Show(false)
		self.user_level4:Show(false)
	end


	self:SetMapSelect()
end

function GameRoom:SetMapSelect()
	self.map_view:SetStaticImageIndex(gameapp.selected_map)
end

function GameRoom:Onready_btnMouseLClick(sender, msg)
	local msg = Message(Evt_Ready_Req)
	gameapp:SendToServer(msg)
end

function GameRoom:Onexit_btnMouseLClick(sender, msg)
	-- Add event hanlder code here
	local msg = Message(Evt_Exit_Req)
	gameapp:SendToServer(msg)
end

function GameRoom:OnHow_btnMouseLClick(sender, msg)	
	if gameapp.gameuser[gameapp.my_user_id].ready == true then
		return
	end

	gameapp:ChangeGameWindow("how")
end

function GameRoom:OnCredit_btnMouseLClick(sender, msg)
	if gameapp.gameuser[gameapp.my_user_id].ready == true then
		return
	end

	gameapp:ChangeGameWindow("credit")
end

function GameRoom:Onsnake1MouseLClick(sender, msg)
	local msg = Message(Evt_SnakeKind_Req)
	msg:SetValue(Evt_SnakeKind_Req.key.kind,1)
	gameapp:SendToServer(msg)
	
end

function GameRoom:Onsnake2MouseLClick(sender, msg)
	local msg = Message(Evt_SnakeKind_Req)
	msg:SetValue(Evt_SnakeKind_Req.key.kind,2)
	gameapp:SendToServer(msg)	
end

function GameRoom:Onsnake3MouseLClick(sender, msg)
	local msg = Message(Evt_SnakeKind_Req)
	msg:SetValue(Evt_SnakeKind_Req.key.kind,3)
	gameapp:SendToServer(msg)
end

function GameRoom:Onsnake4MouseLClick(sender, msg)
	local msg = Message(Evt_SnakeKind_Req)
	msg:SetValue(Evt_SnakeKind_Req.key.kind,4)
	gameapp:SendToServer(msg)
end

function GameRoom:Onsnake5MouseLClick(sender, msg)
	local msg = Message(Evt_SnakeKind_Req)
	msg:SetValue(Evt_SnakeKind_Req.key.kind,5)
	gameapp:SendToServer(msg)
end

function GameRoom:Onsnake6MouseLClick(sender, msg)
	local msg = Message(Evt_SnakeKind_Req)
	msg:SetValue(Evt_SnakeKind_Req.key.kind,6)
	gameapp:SendToServer(msg)
end

function GameRoom:Onsnake7MouseLClick(sender, msg)
	local msg = Message(Evt_SnakeKind_Req)
	msg:SetValue(Evt_SnakeKind_Req.key.kind,7)
	gameapp:SendToServer(msg)
end

function GameRoom:Onbgm_btnMouseLClick(sender, msg)
	-- Add event hanlder code here
	if gameapp.bgm_on == true then
		gameapp.bgm_on = false
		gameapp.snd2:StopSound()
	else
		gameapp.bgm_on = true
		gameapp.snd2:PlaySound(true)
	end	
end

function GameRoom:Ones_btnMouseLClick(sender, msg)
	-- Add event hanlder code here
	if gameapp.es_on == true then
		gameapp.es_on = false
	else
		gameapp.es_on = true
	end	
end

require "GameRoomUIObject"
