require "RGSnake"

class 'RGSnakeManager'

function RGSnakeManager:__init()
	self.snake = {}
	for i =1, 4 do			
		self.snake[i] = self:CreateSnake(1, 1)
	end
end

function RGSnakeManager:SettingStartGame()
	for i =1, 4 do
		if gameapp.gameuser[i].exist == true then
			local snake_id = gameapp.gameuser[i].snake_id
			local color = gameapp.gameuser[i].color
			local kind = gameapp.gameuser[i].snakeKind
			
			self.snake[snake_id]:ChangeImg(color, kind)
			if i == 1 then
				self.snake[snake_id].pos.x = 112+18
				self.snake[snake_id].pos.y = 8+35
			elseif i == 2 then
				self.snake[snake_id].pos.x = 800 - 112 - 18
				--self.snake[snake_id].pos.x = 112+18 +32 --  테스트용 좌표

				self.snake[snake_id].pos.y = 8+16
			elseif i == 3 then
				self.snake[snake_id].pos.x = 112+18
				self.snake[snake_id].pos.y = 600 - 15
			elseif i == 4 then
				self.snake[snake_id].pos.x = 800 - 112 - 18
				self.snake[snake_id].pos.y = 600 - 15
			end

			self.snake[snake_id]:Show(true)

			local msg = Message(Evt_SnakeMove_Req)
			msg:SetValue(Evt_SnakeMove_Req.key.snake_id,snake_id)
			msg:SetValue(Evt_SnakeMove_Req.key.dir,"down")
			msg:SetValue(Evt_SnakeMove_Req.key.x,self.snake[snake_id].pos.x)
			msg:SetValue(Evt_SnakeMove_Req.key.y,self.snake[snake_id].pos.y)

			gameapp:SendToServer(msg)
		end
	end
end

function RGSnakeManager:DataReset()
	for i =1, 4 do
		self.snake[i]:DataReset()
	end	
end

function RGSnakeManager:GetMySnakeId()
	for i = 1, 4 do
		if gameapp.gameuser[i].id == gameapp.my_user_id then
			return gameapp.gameuser[i].snake_id
		end
	end
end

function RGSnakeManager:SendMovePacket2(dir, x, y)

	local snake_id = self:GetMySnakeId()
	
	if self.snake[snake_id].moveEnable == true then
		self.snake[snake_id].moveEnable = false
		local msg = Message(Evt_SnakeMove_Req)
		msg:SetValue(Evt_SnakeMove_Req.key.snake_id, snake_id)
		msg:SetValue(Evt_SnakeMove_Req.key.dir, dir)
		msg:SetValue(Evt_SnakeMove_Req.key.x, x)
		msg:SetValue(Evt_SnakeMove_Req.key.y, y)
		gameapp:SendToServer(msg)
	end
end

function RGSnakeManager:SendMovePacket(dir)	

	local snake_id = self:GetMySnakeId()

	
	anim = self.snake[snake_id].animName
	if	anim == "attack_up" or anim == "attack_down" or anim == "attack_left" or 
		anim == "attack_right" or anim == "dead" then
		return
	end
	

	if dir == "up" then
		local snake_y = self.snake[snake_id].pos.y-1*self.snake[snake_id].spdWalk.y
		self:SendMovePacket2(dir,self.snake[snake_id].pos.x,snake_y)
	elseif dir == "down" then
		local snake_y = self.snake[snake_id].pos.y+1*self.snake[snake_id].spdWalk.y
		self:SendMovePacket2(dir,self.snake[snake_id].pos.x,snake_y)
	elseif dir == "left" then
		local snake_x = self.snake[snake_id].pos.x-1*self.snake[snake_id].spdWalk.x
		self:SendMovePacket2(dir,snake_x,self.snake[snake_id].pos.y)
	elseif dir == "right" then
		local snake_x = self.snake[snake_id].pos.x+1*self.snake[snake_id].spdWalk.x
		self:SendMovePacket2(dir,snake_x,self.snake[snake_id].pos.y)
	end
end

function RGSnakeManager:SendAttackPacket()
	local snake_id = self:GetMySnakeId()
	
	if self.snake[snake_id].attackEnable == true then
		self.snake[snake_id].attackEnable = false

		local msg = Message(Evt_SnakeAttack_Req)
		msg:SetValue(Evt_SnakeAttack_Req.key.snake_id, snake_id)
		msg:SetValue(Evt_SnakeAttack_Req.key.dir, self.snake[snake_id].dir)
		msg:SetValue(Evt_SnakeAttack_Req.key.x, self.snake[snake_id].pos.x)
		msg:SetValue(Evt_SnakeAttack_Req.key.y, self.snake[snake_id].pos.y)
		gameapp:SendToServer(msg)
	end
end

function RGSnakeManager:SetSnakePos(i, dir, x, y, success)
	self.snake[i].dir = dir
	self.snake[i]:ChangeState(dir, true)

	if success == true then
		self.snake[i]:SetXYPos(x,y)
	end

	local snake_id = self:GetMySnakeId()
	if i == snake_id then
		self.snake[snake_id].moveEnable = true
	end
end

function RGSnakeManager:ChangeSnakeState(snake_id, state)
	self.snake[snake_id]:ChangeState(state, true)
end

function RGSnakeManager:Update(elapsed)
	for i = 1, 4 do
		if gameapp.gameuser[i].exist == true then
			local snake_id = gameapp.gameuser[i].snake_id
			self.snake[snake_id]:Update(elapsed)
		end
	end	
end

function RGSnakeManager:CreateSnake(color, kind)
	
	local color_name

	if color == 1 then
		color_name = "red"
	elseif color == 2 then
		color_name = "yellow"
	elseif color == 3 then
		color_name = "green"
	elseif color == 4 then
		color_name = "blue"
	elseif color == 5 then
		color_name = "black"
	elseif color == 6 then
		color_name = "grey"
	elseif color == 7 then
		color_name = "white"
	end
	
	
	local snake = RGSnake()
	snake:CreateOnImage()

	local anim = snake:CreateAnimation("down")
	anim:SetLoop(true)
	anim:SetDelay(0.25)
	anim:SetOffset(18,45)
	anim:AddFrame("images/SNAKE/" .. color_name .. "0" .. kind .. "_walk_down01.png")
	anim:AddFrame("images/SNAKE/" .. color_name .. "0" .. kind .. "_walk_down02.png")
	
	anim = snake:CreateAnimation("up")
	anim:SetLoop(true)
	anim:SetDelay(0.25)
	anim:SetOffset(18,45)
	anim:AddFrame("images/SNAKE/" .. color_name .. "0" .. kind .. "_walk_up01.png")
	anim:AddFrame("images/SNAKE/" .. color_name .. "0" .. kind .. "_walk_up02.png")

	anim = snake:CreateAnimation("left")
	anim:SetLoop(true)
	anim:SetDelay(0.25)
	anim:SetOffset(18,45)
	anim:AddFrame("images/SNAKE/" .. color_name .. "0" .. kind .. "_walk_left01.png")
	anim:AddFrame("images/SNAKE/" .. color_name .. "0" .. kind .. "_walk_left02.png")

	anim = snake:CreateAnimation("right")
	anim:SetLoop(true)
	anim:SetDelay(0.25)
	anim:SetOffset(18,45)
	anim:AddFrame("images/SNAKE/" .. color_name .. "0" .. kind .. "_walk_right01.png")
	anim:AddFrame("images/SNAKE/" .. color_name .. "0" .. kind .. "_walk_right02.png")

	anim = snake:CreateAnimation("dead")
	anim:SetLoop(false)
	anim:SetDelay(0.5)
	anim:SetOffset(18,45)
	anim:AddFrame("images/SNAKE/" .. color_name .. "0" .. kind .. "_walk_dead01.png")
	anim:AddFrame("images/SNAKE/" .. color_name .. "0" .. kind .. "_walk_dead02.png")
	anim:AddFrame("images/SNAKE/" .. color_name .. "0" .. kind .. "_walk_dead03.png")
	anim:AddFrame("images/SNAKE/" .. color_name .. "0" .. kind .. "_walk_dead04.png")

	anim = snake:CreateAnimation("attack_up")
	anim:SetLoop(false)
	anim:SetDelay(0.25)
	anim:SetOffset(48,48)
	anim:AddFrame("images/SNAKE/attack_" .. color_name .. kind .. "_up1.png")
	anim:AddFrame("images/SNAKE/attack_" .. color_name .. kind .. "_up2.png")
	anim:AddFrame("images/SNAKE/attack_" .. color_name .. kind .. "_up3.png")

	anim = snake:CreateAnimation("attack_down")
	anim:SetLoop(false)
	anim:SetDelay(0.25)
	anim:SetOffset(48,48)
	anim:AddFrame("images/SNAKE/attack_" .. color_name .. kind .."_down1.png")
	anim:AddFrame("images/SNAKE/attack_" .. color_name .. kind .."_down2.png")
	anim:AddFrame("images/SNAKE/attack_" .. color_name .. kind .."_down3.png")

	anim = snake:CreateAnimation("attack_left")
	anim:SetLoop(false)
	anim:SetDelay(0.25)
	anim:SetOffset(48,48)
	anim:AddFrame("images/SNAKE/attack_" .. color_name .. kind .. "_left1.png")
	anim:AddFrame("images/SNAKE/attack_" .. color_name .. kind .. "_left2.png")
	anim:AddFrame("images/SNAKE/attack_" .. color_name .. kind .. "_left3.png")

	anim = snake:CreateAnimation("attack_right")
	anim:SetLoop(false)
	anim:SetDelay(0.5)
	anim:SetOffset(48,48)
	anim:AddFrame("images/SNAKE/attack_" .. color_name .. kind .. "_right1.png")
	anim:AddFrame("images/SNAKE/attack_" .. color_name .. kind .. "_right2.png")
	anim:AddFrame("images/SNAKE/attack_" .. color_name .. kind .. "_right3.png")
				
	return snake
end