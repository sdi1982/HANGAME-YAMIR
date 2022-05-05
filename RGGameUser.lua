-- GameUser : 접속한 유저 정보

-- exist : 존재여부
-- major : 방장인지 여부
-- snakeKind : 선택한 뱀 종류
-- color : 선택한 컬러 ( "none": 비초기화 "red": 빨강 "yellow": 노랑 "green": 초록 
--                       "blue": 파랑 "black": 검정 "grey": 회색 "white": 흰색 )
-- score : 총 점수
-- win : 총 승수 
-- lose : 총 패수
-- draw : 총 비긴수
-- location : 현재 위치 ( "none" : 비초기화 "gameroom" : 게임방 "gamewindow" : 게임중 )
-- ready: 준비 상태 ( "none" : 비초기화 "noready" : 준비안됨 "ready" : 준비완료 )

class 'RGGameUser'

function RGGameUser:__init(index)
	self.index = index
	self.id = -1
	self.exist = false
	self.major = false
	self.snakeKind = 1
	self.level = 1
	self.color = 1
	self.score = 0
	self.win = 0
	self.lose = 0
	self.draw = 0
	self.location = "none"
	self.ready = false

	self.snake_id = 0
end

function RGGameUser:SetID(_id)
	self.id = _id
end

function RGGameUser:DataReset()
	self.ready = false	
end
