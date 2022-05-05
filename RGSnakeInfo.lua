-- RGSnakeInfo : 뱀정보
-- InputReverse : 키입력 반대 여부
-- hidden : 성구 안보임
-- shield : 방패 상태
-- moveSpeed :  이동속도
-- attackSpped : 공격속도
-- attackPower : 공격파워
-- snakeState : 캐릭터 상태 ( "normal" : 보통상태, "dragon" : 드래곤, "suffer0" : 일반공격 당함, 
--						"suffer1" : 불공격 당함, "suffer2" : 화염공격 당함, "suffer3" : 가스공격 당함,
--						"suffer4" : 가스공격 당함, "suffer5" : 번개공격 당함, "suffer6" : 얼음공격 당함(10초),
--                      "death" : 죽음 )
-- userState : 유저상태 ( "not_exist" : 존재안함, "ready" : 준비상태, "play" : 게임중, "view" : 관전중,
--							"win" : 이긴상태, "draw" : 비긴상태, "lose" : 진상태, "team_win" : 2:2 이긴 상태,
--							"team_lose" : 2:2 진 상태, "team_draw" : 2:2 비긴상태, "3_win","3_lose","3_draw",
--							"4_win","4_lose","4_draw","sungu_win","sungu_lose"

class 'RGSnakeInfo'

function RGSnakeInfo:__init(id)
	self.inputReverse = false
	self.hidden = false
	self.shield = false
	self.moveSpeed = 1
	self.attackSpeed = 1
	self.attackPower = 1
	self.snakeState = "normal"
	self.userState = "not_exist"
	self.sungu = {}
	for i = 1, 7 do
		self.sungu[i] = false
	end
	self.orderList = {}
	for i = 1, 7 do
		self.orderList = -1
	end
end
