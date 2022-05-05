require "go.ui.Scene"
require "SnakeProtocol"
require "RGUserData"
require "RGSnakeManager"
require "RGItemManager"
require "RGMap"

MAP_LEFT_OFFSET = 112

class 'SnakeScene' (Scene)

function SnakeScene:__init(id)	super(id)
	self:SetupUIObjects()	

	self:SetMsgHandler(Evt_KeyboardDown, self.OnKeyDown)
end

function SnakeScene:GameUISetting()
-- UI를 설정한다.
	local count = 0	
	for i = 1, 4 do
		if gameapp.gameuser[i].id == gameapp.my_user_id then -- 자신일 경우
			if gameapp.gameuser[i].exist == true then
				self.game_user_status1:Show(true)
				self.game_user_status1:SetStaticImageIndex( gameapp.gameuser[i].color - 1)
				self.game_snake1:Show(true)
				--print(gameapp.gameuser[i].snakeKind,gameapp.gameuser[i].color)
				self.game_snake1:SetStaticImageIndex( 9*(gameapp.gameuser[i].snakeKind - 1)+ gameapp.gameuser[i].color -1)
				if gameapp.gameuser[i].major == true then
					self.major1:Show(true)
				else
					self.major1:Show(false)
				end
				self.level1:Show(true)
				self.level1:SetStaticImageIndex( gameapp.gameuser[i].level - 1)
				self.user_id1:Show(true)
			else
				self.game_user_status1:Show(false)
				self.game_snake1:Show(false)
				self.major1:Show(false)
				self.level1:Show(false)
				self.user_id1:Show(false)
			end
		elseif count == 0 then	-- 다른 유저들 
			if gameapp.gameuser[i].exist == true then
				self.game_user_status3:Show(true)
				self.game_user_status3:SetStaticImageIndex( gameapp.gameuser[i].color - 1)
				self.game_snake3:Show(true)
				self.game_snake3:SetStaticImageIndex( 9*(gameapp.gameuser[i].snakeKind - 1)+ gameapp.gameuser[i].color -1)
				if gameapp.gameuser[i].major == true then
					self.major3:Show(true)
				else
					self.major3:Show(false)
				end
				self.level3:Show(true)
				self.level3:SetStaticImageIndex( gameapp.gameuser[i].level - 1)
				self.user_id3:Show(true)
			else
				self.game_user_status3:Show(false)
				self.game_snake3:Show(false)
				self.major3:Show(false)
				self.level3:Show(false)
				self.user_id3:Show(false)
			end
			count = 1
		elseif count == 1 then
			if gameapp.gameuser[i].exist == true then
				self.game_user_status4:Show(true)
				self.game_user_status4:SetStaticImageIndex( gameapp.gameuser[i].color - 1)
				self.game_snake4:Show(true)
				self.game_snake4:SetStaticImageIndex( 9*(gameapp.gameuser[i].snakeKind - 1)+ gameapp.gameuser[i].color -1)
				if gameapp.gameuser[i].major == true then
					self.major4:Show(true)
				else
					self.major4:Show(false)
				end
				self.level4:Show(true)
				self.level4:SetStaticImageIndex( gameapp.gameuser[i].level - 1)
				self.user_id4:Show(true)
			else
				self.game_user_status4:Show(false)
				self.game_snake4:Show(false)
				self.major4:Show(false)
				self.level4:Show(false)
				self.user_id4:Show(false)
			end
			count = 2
		elseif count == 2 then
			if gameapp.gameuser[i].exist == true then
				self.game_user_status5:Show(true)
				self.game_user_status5:SetStaticImageIndex( gameapp.gameuser[i].color - 1)
				self.game_snake5:Show(true)
				self.game_snake5:SetStaticImageIndex( 9*(gameapp.gameuser[i].snakeKind - 1)+ gameapp.gameuser[i].color -1)
				if gameapp.gameuser[i].major == true then
					self.major5:Show(true)
				else
					self.major5:Show(false)
				end
				self.level5:Show(true)
				self.level5:SetStaticImageIndex( gameapp.gameuser[i].level - 1)
				self.user_id5:Show(true)
			else
				self.game_user_status5:Show(false)
				self.game_snake5:Show(false)
				self.major5:Show(false)
				self.level5:Show(false)
				self.user_id5:Show(false)
			end
		end
	end

	self.big_red_ball:Show(false)
	self.big_yellow_ball:Show(false)
	self.big_green_ball:Show(false)
	self.big_blue_ball:Show(false)
	self.big_black_ball:Show(false)
	self.big_grey_ball:Show(false)
	self.big_white_ball:Show(false)


	self.small_red_ball1:Show(false)
	self.small_yellow_ball1:Show(false)
	self.small_green_ball1:Show(false)
	self.small_blue_ball1:Show(false)
	self.small_black_ball1:Show(false)
	self.small_grey_ball1:Show(false)
	self.small_white_ball1:Show(false)

	self.small_red_ball2:Show(false)
	self.small_yellow_ball2:Show(false)
	self.small_green_ball2:Show(false)
	self.small_blue_ball2:Show(false)
	self.small_black_ball2:Show(false)
	self.small_grey_ball2:Show(false)
	self.small_white_ball2:Show(false)

	self.small_red_ball3:Show(false)
	self.small_yellow_ball3:Show(false)
	self.small_green_ball3:Show(false)
	self.small_blue_ball3:Show(false)
	self.small_black_ball3:Show(false)
	self.small_grey_ball3:Show(false)
	self.small_white_ball3:Show(false)

end

function SnakeScene:OnKeyDown(msg)
	local keyValue = msg:GetValue(Evt_KeyboardDown.key.Value)
	--print(keyValue)
	if keyValue == UIConst.KeyUp then
		gameapp.snakeManager:SendMovePacket("up")	
	elseif keyValue == UIConst.KeyDown then
		gameapp.snakeManager:SendMovePacket("down")
	elseif keyValue == UIConst.KeyLeft then
		gameapp.snakeManager:SendMovePacket("left")
	elseif keyValue == UIConst.KeyRight then
		gameapp.snakeManager:SendMovePacket("right")
	elseif keyValue == UIConst.KeySpace then
		gameapp.snakeManager:SendAttackPacket()
	end

end

function SnakeScene:Update(elapsed)
	-- if self:GetKeyPressed(UIConst.KeyUp) then	
	gameapp.snakeManager:Update(elapsed)	
	gameapp.itemManager:Update(elapsed)
end

require "SnakeSceneUIObject"