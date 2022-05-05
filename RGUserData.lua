-- RGUserData : 유저데이터 (네트워크를 통해 공유되어야함)
-- mapInfo : 맵정보
-- snakeInfo[4] : 캐릭터 정보

class 'RGUserData'

function RGUserData:__init()
	self.mapInfo = RGMapInfo(-1);
	self.snakeInfo = {}
	for i = 1, 4 do
		self.snakeInfo[i] = RGSnakeInfo(i)
	end	
end
