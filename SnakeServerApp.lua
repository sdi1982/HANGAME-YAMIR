require "go.app.ServerApp"
require "SnakeProtocol"
require "RGGameUser"
require "RGMap"
require "RGSnake"

class 'SnakeServerApp' (ServerApp)

function SnakeServerApp:__init()	super()	
	math.randomseed(os.time())

	self.gameuser = {}
	self.gameuser[1] = RGGameUser()
	self.gameuser[2] = RGGameUser()
	self.gameuser[3] = RGGameUser()
	self.gameuser[4] = RGGameUser()

	self.gameuser[1].snake_id = 1
	self.gameuser[2].snake_id = 2
	self.gameuser[3].snake_id = 3
	self.gameuser[4].snake_id = 4

	self.selected_map = 0
	self.mapInfo = RGMapInfo(self.selected_map)

	self.snake = {}
	self.snake[1] = RGSnake()
	self.snake[2] = RGSnake()
	self.snake[3] = RGSnake()
	self.snake[4] = RGSnake()
	
	self.time = 180
	self.flogTime = 5
	self.jinsengTime = 5
	self.potionTime = 5
	self.swordTime = 5
	self.dragonPenTime = 10
	self.sunGlassTime = 10
	self.shieldTime = 10
	
	self:SetMsgHandler(Evt_UserStatus_Req, self.OnUserStatusReq)
	self:SetMsgHandler(Evt_MapSelect_Req, self.OnMapSelectReq)
	self:SetMsgHandler(Evt_Ready_Req, self.OnReadyReq)
	self:SetMsgHandler(Evt_Exit_Req, self.OnExitReq)
	self:SetMsgHandler(Evt_Color_Req, self.OnColorReq)	
	self:SetMsgHandler(Evt_SnakeKind_Req, self.OnSnakeKindReq)	
	self:SetMsgHandler(Evt_SnakeMove_Req, self.OnSnakeMoveReq)
	self:SetMsgHandler(Evt_SnakeAttack_Req, self.OnSnakeAttackReq)
	self:SetMsgHandler(Evt_UserMajor_Req, self.OnUserMajorReq)
end

---------------------------------------------------------
-- Game Handler
---------------------------------------------------------
function SnakeServerApp:OnEnterPlayer(player)
	for i = 1, 4 do
		if self.gameuser[i].exist == false then
			self.gameuser[i].exist = true
			self.gameuser[i]:SetID(player.id)
			return
		end
	end
end

function SnakeServerApp:OnLeavePlayer(player)
	for i = 1, 4 do
		if self.gameuser[i].id == player.id then
			self.gameuser[i].exist = false
			self:SendUserStatusAck()
			return
		end
	end
end

---------------------------------------------------------
-- Network Handler
---------------------------------------------------------
function SnakeServerApp:SendUserStatusAck()
	local msg = Message(Evt_UserStatus_Ack)

	msg:SetValue(Evt_UserStatus_Ack.key.user1_id, self.gameuser[1].id)
	msg:SetValue(Evt_UserStatus_Ack.key.user1_exist, self.gameuser[1].exist)
	msg:SetValue(Evt_UserStatus_Ack.key.user1_major, self.gameuser[1].major)
	msg:SetValue(Evt_UserStatus_Ack.key.user1_snake_kind, self.gameuser[1].snakeKind)
	msg:SetValue(Evt_UserStatus_Ack.key.user1_color, self.gameuser[1].color)
	msg:SetValue(Evt_UserStatus_Ack.key.user1_score, self.gameuser[1].score)
	msg:SetValue(Evt_UserStatus_Ack.key.user1_win, self.gameuser[1].win)
	msg:SetValue(Evt_UserStatus_Ack.key.user1_lose, self.gameuser[1].lose)
	msg:SetValue(Evt_UserStatus_Ack.key.user1_draw, self.gameuser[1].draw)
	msg:SetValue(Evt_UserStatus_Ack.key.user1_ready, self.gameuser[1].ready)

	msg:SetValue(Evt_UserStatus_Ack.key.user2_id, self.gameuser[2].id)
	msg:SetValue(Evt_UserStatus_Ack.key.user2_exist, self.gameuser[2].exist)
	msg:SetValue(Evt_UserStatus_Ack.key.user2_major, self.gameuser[2].major)
	msg:SetValue(Evt_UserStatus_Ack.key.user2_snake_kind, self.gameuser[2].snakeKind)
	msg:SetValue(Evt_UserStatus_Ack.key.user2_color, self.gameuser[2].color)
	msg:SetValue(Evt_UserStatus_Ack.key.user2_score, self.gameuser[2].score)
	msg:SetValue(Evt_UserStatus_Ack.key.user2_win, self.gameuser[2].win)
	msg:SetValue(Evt_UserStatus_Ack.key.user2_lose, self.gameuser[2].lose)
	msg:SetValue(Evt_UserStatus_Ack.key.user2_draw, self.gameuser[2].draw)
	msg:SetValue(Evt_UserStatus_Ack.key.user2_ready, self.gameuser[2].ready)

	msg:SetValue(Evt_UserStatus_Ack.key.user3_id, self.gameuser[3].id)
	msg:SetValue(Evt_UserStatus_Ack.key.user3_exist, self.gameuser[3].exist)
	msg:SetValue(Evt_UserStatus_Ack.key.user3_major, self.gameuser[3].major)
	msg:SetValue(Evt_UserStatus_Ack.key.user3_snake_kind, self.gameuser[3].snakeKind)
	msg:SetValue(Evt_UserStatus_Ack.key.user3_color, self.gameuser[3].color)
	msg:SetValue(Evt_UserStatus_Ack.key.user3_score, self.gameuser[3].score)
	msg:SetValue(Evt_UserStatus_Ack.key.user3_win, self.gameuser[3].win)
	msg:SetValue(Evt_UserStatus_Ack.key.user3_lose, self.gameuser[3].lose)
	msg:SetValue(Evt_UserStatus_Ack.key.user3_draw, self.gameuser[3].draw)
	msg:SetValue(Evt_UserStatus_Ack.key.user3_ready, self.gameuser[3].ready)

	msg:SetValue(Evt_UserStatus_Ack.key.user4_id, self.gameuser[4].id)
	msg:SetValue(Evt_UserStatus_Ack.key.user4_exist, self.gameuser[4].exist)
	msg:SetValue(Evt_UserStatus_Ack.key.user4_major, self.gameuser[4].major)
	msg:SetValue(Evt_UserStatus_Ack.key.user4_snake_kind, self.gameuser[4].snakeKind)
	msg:SetValue(Evt_UserStatus_Ack.key.user4_color, self.gameuser[4].color)
	msg:SetValue(Evt_UserStatus_Ack.key.user4_score, self.gameuser[4].score)
	msg:SetValue(Evt_UserStatus_Ack.key.user4_win, self.gameuser[4].win)
	msg:SetValue(Evt_UserStatus_Ack.key.user4_lose, self.gameuser[4].lose)
	msg:SetValue(Evt_UserStatus_Ack.key.user4_draw, self.gameuser[4].draw)
	msg:SetValue(Evt_UserStatus_Ack.key.user4_ready, self.gameuser[4].ready)


	msg:SetValue(Evt_UserStatus_Ack.key.user1_level, self.gameuser[1].level)
	msg:SetValue(Evt_UserStatus_Ack.key.user2_level, self.gameuser[2].level)
	msg:SetValue(Evt_UserStatus_Ack.key.user3_level, self.gameuser[3].level)
	msg:SetValue(Evt_UserStatus_Ack.key.user4_level, self.gameuser[4].level)


	msg:SetValue(Evt_UserStatus_Ack.key.user1_snake_id, self.gameuser[1].snake_id)
	msg:SetValue(Evt_UserStatus_Ack.key.user2_snake_id, self.gameuser[2].snake_id)
	msg:SetValue(Evt_UserStatus_Ack.key.user3_snake_id, self.gameuser[3].snake_id)
	msg:SetValue(Evt_UserStatus_Ack.key.user4_snake_id, self.gameuser[4].snake_id)

	msg:SetValue(Evt_UserStatus_Ack.key.selected_map, self.selected_map)

	self:SendToAll(msg)
end

function SnakeServerApp:OnUserStatusReq(player, msg)
	self:SendUserStatusAck()
end

function SnakeServerApp:OnMapSelectReq(player, msg)

	if self.selected_map == 10 then
		self.selected_map = 0
	else
		self.selected_map = self.selected_map + 1
	end

	if self.selected_map == 1 then	
		self.mapInfo:Map1()
	end

	local msg = Message(Evt_MapSelect_Ack)
	-- msg:SetValue(Evt_MapSelect_Ack.key.selected_map, self.selected_map)
	msg:SetValue(Evt_MapSelect_Ack.key.selected_map, 1) -- 테스트용
	self:SendToAll(msg)
end

function SnakeServerApp:GetUserCount()
	local count = 0

	for i = 1, 4 do
		if self.gameuser[i].exist == true then
			count = count + 1
		end
	end

	return count
end

function SnakeServerApp:GetReadyCount()
	local count = 0
	for i = 1, 4 do
		if	self.gameuser[i].exist == true and
			self.gameuser[i].ready == true then
			count = count + 1	
		end
	end

	return count
end

function SnakeServerApp:OnReadyReq(player, msg)
	for i = 1, 4 do
		if self.gameuser[i].id == player.id then
			if self.gameuser[i].ready == true then
				self.gameuser[i].ready = false
			else
				self.gameuser[i].ready = true
			end
		end
	end

	self:SendUserStatusAck()
	
	local user_count = self:GetUserCount()
	local ready_count = self:GetReadyCount()
	if  user_count == ready_count  then
		local msg = Message(Evt_GameStart_Ack)
		self:SendToAll(msg)

		local result = self:SetTimer(1,1)
		if result == false then
			print("fail setTimer()")
		end
	end
end

function SnakeServerApp:OnTimer(timerid)
	if timerid == 1 then
		self.time = self.time - 1
		local msg = Message(Evt_Time_Ack)
		msg:SetValue(Evt_Time_Ack.key.time, self.time)
		self:SendToAll(msg)
		
		for i = 1, 4 do
			if self.snake[i].bFlog == true then
			-
			end
		end
	end
end
function SnakeServerApp:OnExitReq(player, msg)
	for i = 1, 4 do
		if self.gameuser[i].id == player.id then
			self.gameuser[i].exist = false
		end
	end
	self:SendUserStatusAck()
	local msg = Message(Evt_Exit_Ack)
	self:SendTo(player, msg)
end

function SnakeServerApp:OnColorReq(player, msg)
	local color = msg:GetValue(Evt_Color_Req.key.color)
	for i = 1, 4 do
		if self.gameuser[i].id == player.id then
			self.gameuser[i].color = color
		end
	end
	self:SendUserStatusAck()
end

function SnakeServerApp:OnSnakeKindReq(player, msg)
	local kind = msg:GetValue(Evt_SnakeKind_Req.key.kind)
	for i = 1, 4 do
		if self.gameuser[i].id == player.id then
			self.gameuser[i].snakeKind = kind
		end
	end
	self:SendUserStatusAck()
end

function SnakeServerApp:OnSnakeMoveReq(player, msg)
	local snake_id = msg:GetValue(Evt_SnakeMove_Req.key.snake_id)
	local dir = msg:GetValue(Evt_SnakeMove_Req.key.dir)
	local x = msg:GetValue(Evt_SnakeMove_Req.key.x)
	local y = msg:GetValue(Evt_SnakeMove_Req.key.y)

	if x < 112 + 10 then
		x = 112 + 10
	elseif x > (800 - 112 - 10) then
		x = 800 - 112 - 10
	end 
		
	if y < 24 then
		y = 24
	elseif y > 600 - 15 then
		y = 600 - 15
	end

	local msg = Message(Evt_SnakeMove_Ack)
	
	self.snake[snake_id].dir = dir

	msg:SetValue(Evt_SnakeMove_Ack.key.snake_id, snake_id)
	msg:SetValue(Evt_SnakeMove_Ack.key.dir, dir)
	--print("move_ack snake_id",snake_id)
	if self:CheckMove(snake_id,dir, x,y) == true then
		self.snake[snake_id].pos.x = x
		self.snake[snake_id].pos.y = y

		msg:SetValue(Evt_SnakeMove_Ack.key.x, x)
		msg:SetValue(Evt_SnakeMove_Ack.key.y, y)
		msg:SetValue(Evt_SnakeMove_Ack.key.success, true)
		self:SendToAll(msg)
	else
		msg:SetValue(Evt_SnakeMove_Ack.key.success, false)
		self:SendTo(player, msg)
	end
end

function SnakeServerApp:SendMoveWall(dir, i, j)
	local m, n
	if dir == "up" then
		m = i
		n = j-1
	elseif dir == "down" then
		m = i
		n = j+1		
	elseif dir == "left" then
		m = i-1
		n = j
	elseif dir == "right" then
		m = i+1
		n = j
	end

	if m < 1 or m > 18 or n < 1 or n > 18 then
		return false
	end

	if self.mapInfo.wTile[i][j] == 5 and self.mapInfo.wTile[m][n] == -1 then
		self.mapInfo.wTile[i][j] = -1
		self.mapInfo.wTile[m][n] = 5

		local msg = Message(Evt_ChangeWall_Ack)
	
		msg:SetValue(Evt_ChangeWall_Ack.key.wall_i, i)
		msg:SetValue(Evt_ChangeWall_Ack.key.wall_j, j)
		msg:SetValue(Evt_ChangeWall_Ack.key.wall_index, self.mapInfo.wTile[i][j])
		self:SendToAll(msg)

		msg:SetValue(Evt_ChangeWall_Ack.key.wall_i, m)
		msg:SetValue(Evt_ChangeWall_Ack.key.wall_j, n)
		msg:SetValue(Evt_ChangeWall_Ack.key.wall_index, self.mapInfo.wTile[m][n])
		self:SendToAll(msg)

		return true
	end

	return false
end

function SnakeServerApp:CheckMove(snake_id, dir, x,y)

	local snake_rect = Rect(x-10,y-5,x+10,y+15)

	local i = (x - 112)/32 + 1
	local j = (y - 8)/32 + 1
	i = i - i%1
	j = j - j%1


	--print("snake",i,j)
	--print("X:",x,"Y:",y)
	--print("----------------------")
	if self:IntersectItem(snake_rect,i,j) == true then
		local msg = Message(Evt_UseItem_Ack)
	
		msg:SetValue(Evt_UseItem_Ack.key.snake_id, snake_id)
		msg:SetValue(Evt_UseItem_Ack.key.kind, self.mapInfo.item[i][j])
		msg:SetValue(Evt_UseItem_Ack.key.i, i)
		msg:SetValue(Evt_UseItem_Ack.key.j, j)
		self:SendToAll(msg)
		
		self.mapInfo.item[i][j] = -1
	end

	local inter
	if dir == "up" then
		inter = self:IntersectRect(snake_rect,i,j-1)
		if inter == true then
			self:SendMoveWall(dir,i,j-1)
			return false
		end
		inter = self:IntersectRect(snake_rect,i-1,j-1)
		if inter == true then
			self:SendMoveWall(dir,i-1,j-1)
			return false
		end
		inter = self:IntersectRect(snake_rect,i+1,j-1)
		if inter == true then
			self:SendMoveWall(dir,i+1,j-1)
			return false
		end


	elseif dir == "down" then
		inter = self:IntersectRect(snake_rect,i,j)
		if inter == true then
			self:SendMoveWall(dir,i,j)
			return false
		end
		inter = self:IntersectRect(snake_rect,i-1,j)
		if inter == true then
			self:SendMoveWall(dir,i-1,j)
			return false
		end
		inter = self:IntersectRect(snake_rect,i+1,j)
		if inter == true then
			self:SendMoveWall(dir,i+1,j)
			return false
		end
	elseif dir == "left" then
		inter = self:IntersectRect(snake_rect,i-1,j)
		if inter == true then
			self:SendMoveWall(dir,i-1,j)
			return false
		end
		inter = self:IntersectRect(snake_rect,i-1,j+1)
		if inter == true then
			self:SendMoveWall(dir,i-1,j+1)
			return false
		end
		inter = self:IntersectRect(snake_rect,i-1,j-1)
		if inter == true then
			self:SendMoveWall(dir,i-1,j-1)
			return false
		end
	elseif dir == "right" then
		inter = self:IntersectRect(snake_rect,i+1,j)
		if inter == true then
			self:SendMoveWall(dir,i+1,j)
			return false
		end
		inter = self:IntersectRect(snake_rect,i+1,j+1)
		if inter == true then
			self:SendMoveWall(dir,i+1,j+1)
			return false
		end
		inter = self:IntersectRect(snake_rect,i+1,j-1)
		if inter == true then
			self:SendMoveWall(dir,i+1,j-1)
			return false
		end
	end

	return true
end

function SnakeServerApp:IntersectRect(snake_rect,i,j)
	if i < 1 or i > 18 or j < 1 or j > 18 then
		return false
	end

	if self.mapInfo.wTile[i][j] ~= -1 then
		--print("wall",i,j)
		--print("left",112+32*(i-1),"right",112+32*i)
		--print("top",24+32*(j-1),"down",24+32*j)
		local rect = Rect(112+32*(i-1),24+32*(j-1),112+32*i,24+32*j)
		local inter = snake_rect:IntersectRect(rect)
		--print(inter)
		--print("=============================")
		return inter
	end
	return false
end

function SnakeServerApp:IntersectItem(snake_rect,i,j)
	if i < 1 or i > 18 or j < 1 or j > 18 then
		return false
	end

	if self.mapInfo.item[i][j] ~= -1 then -- 아이템 충돌체크
		local rect = Rect(112+32*(i-1),24+32*(j-1),112+32*i,24+32*j)
		local inter = snake_rect:IntersectRect(rect)
		return inter
	end
	return false
end

function SnakeServerApp:OnSnakeAttackReq(player, msg)
	local snake_id = msg:GetValue(Evt_SnakeAttack_Req.key.snake_id)
	local dir = msg:GetValue(Evt_SnakeAttack_Req.key.dir)
	local x = msg:GetValue(Evt_SnakeAttack_Req.key.x)
	local y = msg:GetValue(Evt_SnakeAttack_Req.key.y)
	
	if x < 112 + 10 then
		x = 112 + 10
	elseif x > (800 - 112 - 10) then
		x = 800 - 112 - 10
	end 
		
	if y < 24 then
		y = 24
	elseif y > 600 - 15 then
		y = 600 - 15
	end


	self:SendAttackDirAck(snake_id, dir)
	self:CheckAttack(snake_id, dir, x,y)
	-- TODO:다른 스네이크 공격 처리를 추가
end

function SnakeServerApp:SendAttackDirAck(snake_id, dir)
	local msg = Message(Evt_SnakeAttack_Ack)
	
	msg:SetValue(Evt_SnakeAttack_Ack.key.snake_id, snake_id)

	if dir == "up" then
		msg:SetValue(Evt_SnakeAttack_Ack.key.attack_dir, "attack_up")
	elseif dir == "down" then
		msg:SetValue(Evt_SnakeAttack_Ack.key.attack_dir, "attack_down")
	elseif dir == "left" then
		msg:SetValue(Evt_SnakeAttack_Ack.key.attack_dir, "attack_left")
	elseif dir == "right" then
		msg:SetValue(Evt_SnakeAttack_Ack.key.attack_dir, "attack_right")
	end

	self:SendToAll(msg)	
end

function SnakeServerApp:SendCreateItemAck(snake_id,i,j)
	-- 아이템 종류를 랜덤을 돌린다.
	math.randomseed(os.date("%d%H%M%S"))
	local kind = math.random(0, 7)
	self.mapInfo.wTile[i][j] = -1
	self.mapInfo.item[i][j] = kind

	if kind == 1 then -- flog
		self.snake[snake_id].bFlog = true
	elseif kind == 2 then -- jinseng
		self.snake[snake_id].bJinseng = true
	elseif kind == 3 then
		self.snake[snake_id].bPotion = true
	elseif kind == 4 then
		self.snake[snake_id].bSword = true
	elseif kind == 5 then
		self.snake[snake_id].bDragonPen = true
	elseif kind == 6 then
		self.snake[snake_id].bSunGlass = true
	elseif kind == 7 then
		self.snake[snake_id].bShield = true
	end

	local msg = Message(Evt_CreateItem_Ack)
	msg:SetValue(Evt_CreateItem_Ack.key.kind, kind)
	msg:SetValue(Evt_CreateItem_Ack.key.i, i)
	msg:SetValue(Evt_CreateItem_Ack.key.j, j)
	self:SendToAll(msg)
end

function SnakeServerApp:SendChangeWall(snake_id,i,j)
	local index = self.mapInfo.wTile[i][j]
	if index == 1 then
		if self.snake[snake_id].attackPower == 1 then
			self.mapInfo.wTile[i][j] = 0
		elseif self.snake[snake_id].attackPower == 2 then
			self.mapInfo.wTile[i][j] = -1
		end
	elseif index == 2 then
		if self.snake[snake_id].attackPower == 1 then
			self.mapInfo.wTile[i][j] = 6
		elseif self.snake[snake_id].attackPower == 2 then
			self:SendCreateItemAck(snake_id,i,j)
		end
	elseif index == 0 then
		self.mapInfo.wTile[i][j] = -1
	elseif index == 6 then
		self:SendCreateItemAck(snake_id,i,j)
	end

	local msg = Message(Evt_ChangeWall_Ack)

	msg:SetValue(Evt_ChangeWall_Ack.key.wall_i, i)
	msg:SetValue(Evt_ChangeWall_Ack.key.wall_j, j)
	msg:SetValue(Evt_ChangeWall_Ack.key.wall_index, self.mapInfo.wTile[i][j])
	self:SendToAll(msg)
end

function SnakeServerApp:CheckGameOver()
	local winner_user_id = -1

	local temp_user_id = -1
	local count = 0

	for i = 1, 4 do
		if	self.gameuser[i].exist == true then
			local snake_id = self.gameuser[i].snake_id 
			if self.snake[snake_id].exist == true then
				temp_user_id = self.gameuser[i].id
				count = count + 1
			end
		end
	end
	
	if count == 1 then
		winner_user_id = temp_user_id
	end

	return winner_user_id
end

function SnakeServerApp:DataReset()
	for i = 1, 4 do
		self.gameuser[i]:DataReset()
		self.snake[i]:DataReset()
	end
	self.mapInfo:DataReset()

	self:KillTimer(1)
	self.time = 180
end

function SnakeServerApp:CheckIntersectSnake(snake_id,attack_rect)
	local inter = false

	for q =1, 4 do
		if self.gameuser[q].exist == true and q ~= snake_id then
			local snake_id2 = self.gameuser[q].snake_id
			local x2 = self.snake[snake_id2].pos.x
			local y2 = self.snake[snake_id2].pos.y
			local rect2 = Rect(x2-15,y2-15,x2+15,y2+15)

			inter = attack_rect:IntersectRect(rect2)

			--print("suffer")
			--print("left",x2-15,"right",x2+15)
			--print("top",y2-15,"bottom",y2+15)
			--print(inter)

			if	inter == true and
				self.snake[snake_id2].exist == true then

				self.snake[snake_id2].exist = false
				self.snake[snake_id2].animName = "dead" -- 클라이언트에서는 "dead"후에 "down"이됨
	
				local msg = Message(Evt_SnakeSuffer_Ack)
				
				msg:SetValue(Evt_SnakeSuffer_Ack.key.snake_id, snake_id2)
				msg:SetValue(Evt_SnakeSuffer_Ack.key.state, "dead")
				
				self:SendToAll(msg)

				-- 게임이 끝났는지 확인
				local winner_user_id = self:CheckGameOver()
				
				if winner_user_id ~= -1 then
					local msg = Message(Evt_GameOver_Ack)
					msg:SetValue(Evt_GameOver_Ack.key.winner_user_id, winner_user_id)
					self:SendToAll(msg)

					-- 게임정보를 초기화 한다.
					self:DataReset()
					-- 유저정보를 보낸다.
					self:SendUserStatusAck()
				end
				
				return true
			end
		end
	end

	return false
end

function SnakeServerApp:CheckAttack(snake_id, dir, x, y)
	
	local i = (x - 112)/32 + 1
	local j = (y - 8)/32 + 1
	i = i - i%1
	j = j - j%1


	--print("attack",i,j)
	--print("left:",x-18,"right:",x+18)
	--print("top:",y+24,"bottom:",y+48)
	--print("----------------------")
	local inter
	local attack_rect
	if dir == "up" then
		attack_rect = Rect(x-10,y-48,x+10,y-28)
		inter = self:IntersectRect(attack_rect,i,j-1)
		if inter == true then
			self:SendChangeWall(snake_id,i,j-1)
		end
		inter = self:IntersectRect(attack_rect,i-1,j-1)
		if inter == true then
			self:SendChangeWall(snake_id,i-1,j-1)
		end
		inter = self:IntersectRect(attack_rect,i+1,j-1)
		if inter == true then
			self:SendChangeWall(snake_id,i+1,j-1)
		end

		self:CheckIntersectSnake(snake_id,attack_rect)
	elseif dir == "down" then
		attack_rect = Rect(x-10,y+28,x+10,y+48)
		inter = self:IntersectRect(attack_rect,i,j+1)
		if inter == true then
			self:SendChangeWall(snake_id,i,j+1)
		end
		inter = self:IntersectRect(attack_rect,i-1,j+1)
		if inter == true then
			self:SendChangeWall(snake_id,i-1,j+1)
		end
		inter = self:IntersectRect(attack_rect,i+1,j+1)
		if inter == true then
			self:SendChangeWall(snake_id,i+1,j+1)
		end

		self:CheckIntersectSnake(snake_id,attack_rect)

	elseif dir == "left" then
		attack_rect = Rect(x-48,y-18,x-28,y+2)
		inter = self:IntersectRect(attack_rect,i-1,j)
		if inter == true then
			self:SendChangeWall(snake_id,i-1,j)
		end
		inter = self:IntersectRect(attack_rect,i-1,j+1)
		if inter == true then
			self:SendChangeWall(snake_id,i-1,j+1)
		end
		inter = self:IntersectRect(attack_rect,i-1,j-1)
		if inter == true then
			self:SendChangeWall(snake_id,i-1,j-1)
		end

		self:CheckIntersectSnake(snake_id,attack_rect)

	elseif dir == "right" then
		attack_rect = Rect(x+28,y-18,x+48,y+2)
		inter = self:IntersectRect(attack_rect,i+1,j)
		if inter == true then
			self:SendChangeWall(snake_id,i+1,j)
		end
		inter = self:IntersectRect(attack_rect,i+1,j+1)
		if inter == true then
			self:SendChangeWall(snake_id,i+1,j+1)
		end
		inter = self:IntersectRect(attack_rect,i+1,j-1)
		if inter == true then
			self:SendChangeWall(snake_id,i+1,j-1)
		end

		self:CheckIntersectSnake(snake_id,attack_rect)
	end

	return true
end

function SnakeServerApp:OnUserMajorReq(player, msg)
	local major_id = msg:GetValue(OnUserMajorReq.key.user_id)

	for i = 1, 4 do
		if  self.gameuser[i].id == major_id then
			self.gameuser[i].major = true
		end
	end
end
