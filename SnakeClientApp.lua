require "go.app.ClientApp"

require "SnakeScene"
require "GameRoom"
require "SnakeProtocol"
require "RevLogo"
require "Title"
require "Credit"
require "How"

class 'SnakeClientApp' (ClientApp)

function SnakeClientApp:__init() super()
	math.randomseed(os.time())

	self:LoadXML("Scene.xml", true)

	self.revLogo = RevLogo(3)
	self.title = Title(4)
	self.credit = Credit(5)
	self.how = How(8)
	self.game_room = GameRoom(2)
	self.game_scene = SnakeScene(1)

	self:ActivateScene(self.revLogo)
	
	self:SetupSoundObjects()

	self.my_user_id = 0
	
	self.es_on = true
	self.bgm_on = true

	self.gameuser = {}
	self.gameuser[1] = RGGameUser(1)
	self.gameuser[2] = RGGameUser(2)
	self.gameuser[3] = RGGameUser(3)
	self.gameuser[4] = RGGameUser(4)

	self.map = RGMap()

	self.snakeManager = RGSnakeManager()
	self.itemManager = RGItemManager()

	-- record current time
	self.lastsec = self:GetCurrentSeconds()
	
	self:SetMsgHandler(Evt_UserStatus_Ack, self.OnUserStatusAck)
	self:SetMsgHandler(Evt_MapSelect_Ack, self.OnMapSelectAck)
	self:SetMsgHandler(Evt_Exit_Ack, self.OnExitAck)
	self:SetMsgHandler(Evt_SnakeMove_Ack,self.OnSnakeMoveAck)
	self:SetMsgHandler(Evt_ChangeWall_Ack,self.OnChangeWallAck)
	self:SetMsgHandler(Evt_SnakeAttack_Ack,self.OnSnakeAttackAck)
	self:SetMsgHandler(Evt_SnakeSuffer_Ack,self.OnSnakeSufferAck)
	self:SetMsgHandler(Evt_GameStart_Ack,self.OnGameStartAck)
	self:SetMsgHandler(Evt_GameOver_Ack,self.OnGameOverAck)
	self:SetMsgHandler(Evt_Time_Ack,self.OnGameTimeAck)
	self:SetMsgHandler(Evt_CreateItem_Ack,self.OnCreateItemAck)
	self:SetMsgHandler(Evt_UseItem_Ack,self.OnUseItemAck)
end

function SnakeClientApp:ChangeGameWindow(game_state)
	if game_state == "game_room" then
		if gameapp.bgm_on == true then
			gameapp.snd8:StopSound()
			gameapp.snd2:PlaySound(true)
		end
		self:ActivateScene(self.game_room)
	elseif game_state == "game_scene" then
		if gameapp.bgm_on == true then
			gameapp.snd2:StopSound()
			gameapp.snd8:PlaySound(true)
		end
		self:ActivateScene(self.game_scene)
	elseif game_state == "rev_logo" then
		self:ActivateScene(self.revLogo)
	elseif game_state == "title" then
		self:ActivateScene(self.title)
	elseif game_state == "credit" then
		self:ActivateScene(self.credit)
	elseif game_state == "how" then
		self:ActivateScene(self.how)
	end
end
---------------------------------------------------------
-- Game Handler
---------------------------------------------------------
function SnakeClientApp:OnEnterGame(player)
	self.my_user_id = player.id
	print("my_user_id:",self.my_user_id)
	
	local msg = Message(Evt_UserStatus_Req)
	self:SendToServer(msg)
end

function SnakeClientApp:OnLeaveGame(player)

end

function SnakeClientApp:OnDisconnected()

end

function SnakeClientApp:OnEnterPlayer(player)

end

function SnakeClientApp:OnLeavePlayer(player)

end

function SnakeClientApp:OnTimer(timerid)

end

function SnakeClientApp:Update(seconds)
	self.currentScene:Update(seconds - self.lastsec)
	self.lastsec = seconds
end

---------------------------------------------------------
-- Network Handler
---------------------------------------------------------
function SnakeClientApp:OnUserStatusAck(player, msg)
-- 서버로부터 자신이 추가된 유저정보와 맵정보를 받고 정보를 갱신한다.
	self.gameuser[1].id = msg:GetValue(Evt_UserStatus_Ack.key.user1_id)
	self.gameuser[1].exist = msg:GetValue(Evt_UserStatus_Ack.key.user1_exist)
	self.gameuser[1].major = msg:GetValue(Evt_UserStatus_Ack.key.user1_major)
	self.gameuser[1].snakeKind = msg:GetValue(Evt_UserStatus_Ack.key.user1_snake_kind)
	self.gameuser[1].color = msg:GetValue(Evt_UserStatus_Ack.key.user1_color)
	self.gameuser[1].score = msg:GetValue(Evt_UserStatus_Ack.key.user1_score)
	self.gameuser[1].win = msg:GetValue(Evt_UserStatus_Ack.key.user1_win)
	self.gameuser[1].lose = msg:GetValue(Evt_UserStatus_Ack.key.user1_lose)
	self.gameuser[1].draw = msg:GetValue(Evt_UserStatus_Ack.key.user1_draw)
	self.gameuser[1].ready = msg:GetValue(Evt_UserStatus_Ack.key.user1_ready)

	self.gameuser[2].id = msg:GetValue(Evt_UserStatus_Ack.key.user2_id)
	self.gameuser[2].exist = msg:GetValue(Evt_UserStatus_Ack.key.user2_exist)
	self.gameuser[2].major = msg:GetValue(Evt_UserStatus_Ack.key.user2_major)
	self.gameuser[2].snakeKind = msg:GetValue(Evt_UserStatus_Ack.key.user2_snake_kind)
	self.gameuser[2].color = msg:GetValue(Evt_UserStatus_Ack.key.user2_color)
	self.gameuser[2].score = msg:GetValue(Evt_UserStatus_Ack.key.user2_score)
	self.gameuser[2].win = msg:GetValue(Evt_UserStatus_Ack.key.user2_win)
	self.gameuser[2].lose = msg:GetValue(Evt_UserStatus_Ack.key.user2_lose)
	self.gameuser[2].draw = msg:GetValue(Evt_UserStatus_Ack.key.user2_draw)
	self.gameuser[2].ready = msg:GetValue(Evt_UserStatus_Ack.key.user2_ready)

	self.gameuser[3].id = msg:GetValue(Evt_UserStatus_Ack.key.user3_id)
	self.gameuser[3].exist = msg:GetValue(Evt_UserStatus_Ack.key.user3_exist)
	self.gameuser[3].major = msg:GetValue(Evt_UserStatus_Ack.key.user3_major)
	self.gameuser[3].snakeKind = msg:GetValue(Evt_UserStatus_Ack.key.user3_snake_kind)
	self.gameuser[3].color = msg:GetValue(Evt_UserStatus_Ack.key.user3_color)
	self.gameuser[3].score = msg:GetValue(Evt_UserStatus_Ack.key.user3_score)
	self.gameuser[3].win = msg:GetValue(Evt_UserStatus_Ack.key.user3_win)
	self.gameuser[3].lose = msg:GetValue(Evt_UserStatus_Ack.key.user3_lose)
	self.gameuser[3].draw = msg:GetValue(Evt_UserStatus_Ack.key.user3_draw)
	self.gameuser[3].ready = msg:GetValue(Evt_UserStatus_Ack.key.user3_ready)

	self.gameuser[4].id = msg:GetValue(Evt_UserStatus_Ack.key.user4_id)
	self.gameuser[4].exist = msg:GetValue(Evt_UserStatus_Ack.key.user4_exist)
	self.gameuser[4].major = msg:GetValue(Evt_UserStatus_Ack.key.user4_major)
	self.gameuser[4].snakeKind = msg:GetValue(Evt_UserStatus_Ack.key.user4_snake_kind)
	self.gameuser[4].color = msg:GetValue(Evt_UserStatus_Ack.key.user4_color)
	self.gameuser[4].score = msg:GetValue(Evt_UserStatus_Ack.key.user4_score)
	self.gameuser[4].win = msg:GetValue(Evt_UserStatus_Ack.key.user4_win)
	self.gameuser[4].lose = msg:GetValue(Evt_UserStatus_Ack.key.user4_lose)
	self.gameuser[4].draw = msg:GetValue(Evt_UserStatus_Ack.key.user4_draw)
	self.gameuser[4].ready = msg:GetValue(Evt_UserStatus_Ack.key.user4_ready)


	self.gameuser[1].level = msg:GetValue(Evt_UserStatus_Ack.key.user1_level)
	self.gameuser[2].level = msg:GetValue(Evt_UserStatus_Ack.key.user2_level)
	self.gameuser[3].level = msg:GetValue(Evt_UserStatus_Ack.key.user3_level)
	self.gameuser[4].level = msg:GetValue(Evt_UserStatus_Ack.key.user4_level)


	self.gameuser[1].snake_id = msg:GetValue(Evt_UserStatus_Ack.key.user1_snake_id)
	self.gameuser[2].snake_id = msg:GetValue(Evt_UserStatus_Ack.key.user2_snake_id)
	self.gameuser[3].snake_id = msg:GetValue(Evt_UserStatus_Ack.key.user3_snake_id)
	self.gameuser[4].snake_id = msg:GetValue(Evt_UserStatus_Ack.key.user4_snake_id)
	
	local selected_map2 = msg:GetValue(Evt_UserStatus_Ack.key.selected_map)

	if self.selected_map ~= selected_map2 then
		self.selected_map = selected_map2
			
		if self.selected_map == 1 then
			self.map.mapInfo:Map1()
		elseif self.selected_map == 2 then
			self.map.mapInfo:Map1()
		end

		self.map:ChangeMapInfo(self.map.mapInfo)
	end
	
	self.game_room:SetUserStatus()
end


function SnakeClientApp:UserCount()

	local user_count = 0
	for i = 1, 4 do
		if self.gameuser[i].exist == true then
			user_count = user_count + 1
		end
	end
	
	return user_count
end

function SnakeClientApp:OnMapSelectAck(player, msg)
	self.selected_map = msg:GetValue(Evt_MapSelect_Ack.key.selected_map)
	
	if self.selected_map == 1 then
		self.map.mapInfo:Map1()
	end
	self.map:ChangeMapInfo(self.map.mapInfo)
	self.game_room:SetMapSelect()
end

function SnakeClientApp:OnExitAck(player, msg)
	gameapp:ExitGame()
end

function SnakeClientApp:OnSnakeMoveAck(player, msg)
	snake_id = msg:GetValue(Evt_SnakeMove_Ack.key.snake_id)
	dir = msg:GetValue(Evt_SnakeMove_Ack.key.dir)
	x = msg:GetValue(Evt_SnakeMove_Ack.key.x)
	y = msg:GetValue(Evt_SnakeMove_Ack.key.y)
	success = msg:GetValue(Evt_SnakeMove_Ack.key.success)

	self.snakeManager:SetSnakePos(snake_id, dir, x, y, success)

	--if dir == "up" or dir == "down" then
	--	self:SortWall()
	--end
end


function SnakeClientApp:OnSnakeAttackAck(player, msg)
	snake_id = msg:GetValue(Evt_SnakeAttack_Ack.key.snake_id)
	attack_dir = msg:GetValue(Evt_SnakeAttack_Ack.key.attack_dir)
	self.snakeManager:ChangeSnakeState(snake_id, attack_dir)
end

function SnakeClientApp:OnChangeWallAck(player, msg)
	local i = msg:GetValue(Evt_ChangeWall_Ack.key.wall_i)
	local j = msg:GetValue(Evt_ChangeWall_Ack.key.wall_j)
	local index = msg:GetValue(Evt_ChangeWall_Ack.key.wall_index)

	self.map.wallTile[i][j]:LoadImage(index,i,j)
end

function SnakeClientApp:OnSnakeSufferAck(player, msg)
	local snake_id = msg:GetValue(Evt_SnakeSuffer_Ack.key.snake_id)	
	local state = msg:GetValue(Evt_SnakeSuffer_Ack.key.state)

	self.snakeManager:ChangeSnakeState(snake_id, state)
end


function SnakeClientApp:OnGameStartAck(player, msg)

	--스네이크의 컬러, 종류를 설정한다.
	self.snakeManager:SettingStartGame()
	 
	-- 게임UI를 설정한다.
	self.game_scene:GameUISetting()

	-- 씬 화면을 게임윈도우로 바꾼다.
	self:ChangeGameWindow("game_scene")

end

function SnakeClientApp:DataReset()
	self.map.mapInfo:DataReset()
	self.map:ChangeMapInfo(self.map.mapInfo)
	self.snakeManager:DataReset()


	self.game_scene.time:LoadNumberImage("images/number1.png",10,1,nil,nil)
	self.game_scene.time:SetNumber(180)
end

function SnakeClientApp:OnGameOverAck(player, msg)
	local winner_user_id = msg:GetValue(Evt_GameOver_Ack.key.winner_user_id)

	if winner_user_id == self.my_user_id then
		self.game_scene.message:SetStaticImageIndex(2)
	else
		self.game_scene.message:SetStaticImageIndex(3)
	end
	
	self.game_scene.message:BringToTop()
	self.game_scene.message:Show(true)
	WaitSec(3)
	self.game_scene.message:Show(false)

	-- 게임정보를 초기화하고 방으로 전환
	self:ChangeGameWindow("game_room")
	self:DataReset()
end

function SnakeClientApp:OnGameTimeAck(player, msg)
	local time = msg:GetValue(Evt_Time_Ack.key.time)
	if time == 30 then
		self.game_scene.time:LoadNumberImage("images/number2.png",10,1,nil,nil)
	end
	
	if time > -1 then
		self.game_scene.time:SetNumber(time)
		
		-- 1초당 한번씩 정렬을 해준다.
		-- self:SortWallAndSnake()
	end 
	
	if time == 0 then
		self.game_scene.message:SetStaticImageIndex(4)
		self.game_scene.message:BringToTop()
		self.game_scene.message:Show(true)
		WaitSec(3)
		self.game_scene.message:Show(false)
	
		-- 게임정보를 초기화하고 방으로 전환
		self:ChangeGameWindow("game_room")
		self:DataReset()
	end
end

function SnakeClientApp:OnCreateItemAck(player, msg)
	local kind = msg:GetValue(Evt_CreateItem_Ack.key.kind)
	local i = msg:GetValue(Evt_CreateItem_Ack.key.i)
	local j = msg:GetValue(Evt_CreateItem_Ack.key.j)
	self.map.mapInfo.item[i][j] = kind
	self.itemManager:CreateItem(kind,i,j)
end


function SnakeClientApp:OnUseItemAck(player, msg)
	local snake_id = msg:GetValue(Evt_UseItem_Ack.key.snake_id)
	local kind = msg:GetValue(Evt_UseItem_Ack.key.kind)
	local i = msg:GetValue(Evt_UseItem_Ack.key.i)
	local j = msg:GetValue(Evt_UseItem_Ack.key.j)
	
	-- 각 아이템별로 snake 객체를 변화 시킨다.
	if kind == 1 then
		self.snakeManager.snake[snake_id]:OnStartFlogAck()
	elseif kind == 2 then
		self.snakeManager.snake[snake_id]:OnStartJinsengAck()
	elseif kind == 3 then
		self.snakeManager.snake[snake_id]:OnStartPotionAck()
	elseif kind == 4 then
		self.snakeManager.snake[snake_id]:OnStartSwordAck()
	elseif kind == 5 then
		self.snakeManager.snake[snake_id]:OnStartDragonPenAck()
	elseif kind == 6 then
		self.snakeManager.snake[snake_id]:OnStartSunGlassAck()
	elseif kind == 7 then
		self.snakeManager.snake[snake_id]:OnStartShieldAck()
	end
	
	self.map.mapInfo.item[i][j] = -1
	self.itemManager:RemoveItem(i*18+j)	
	
end
-- j좌표순으로 맵과 스네이크를 그리는 순서를 정렬한다.
function SnakeClientApp:SortWallAndSnake()

	local snake_j = {}
	for i = 1, 4 do
		snake_j[i] = self.snakeManager.snake[i].pos.y/32
		snake_j[i] = snake_j[i] - snake_j[i]%1
	end
	
		
	for j = 1, 18 do
		for i = 1, 18 do
			if self.map.wallTile[i][j].index ~= -1 then
				self.map.wallTile[i][j]:BringToTop()
			end
		end

		for q = 1, 4 do
			if snake_j[q] == j then
				self.snakeManager.snake[q]:BringToTop()
			end
		end
	end
end

--function SnakeClientApp:SortWall()
--
--	for q = 1, 4 do
--		self.snakeManager.snake[q]:BringToTop()
--	end
--
--	for j = 1, 18 do
--		for i = 1, 18 do
--			if self.map.wallTile[i][j].index ~= -1 then
--				self.map.wallTile[i][j]:BringToTop()
--			end
--		end
--	end
--end

--function SnakeClientApp:BringUp18(snake_j)
--	for i = 1, 18 do
--		self.snakeManager.snake[q]:BringUp()
--	end
--end
--
--function SnakeClientApp:BringDown18(snake_j)
--	for i = 1, 18 do
--		self.snakeManager.snake[q]:BringDown()
--	end
--end
--
--function SnakeClientApp:SortSnake()
--	local snake_j = {}
--	for i = 1, 4 do
--		snake_j[i] = self.snakeManager.snake[i].pos.y/32
--		snake_j[i] = snake_j[i] - snake_j[i]%1
--	end
--
--	
--	for q = 1, 4 do
--		if snake_j[q] == j then
--			self.snakeManager.snake[q]:BringToTop()
--		end
--	end
--end

require "SnakeSoundObject"
