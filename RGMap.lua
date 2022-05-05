require "RGMapInfo"
require "RGGround"
require "RGWall"

MAP_TOP_OFFSET = 24

class 'RGMap'

function RGMap:__init()
	self.mapInfo = RGMapInfo(0)
	self.groundTile = {}
	for i = 1, 18 do
		self.groundTile[i] = {}
		for j = 1, 18 do
			self.groundTile[i][j] = RGGround()			
		end
	end
	self.wallTile = {}
	for i = 1, 18 do
		self.wallTile[i] = {}
		for j = 1, 18 do
			self.wallTile[i][j] = RGWall()
		end
	end
end

function RGMap:ChangeMapInfo(mapInfo)
	for i = 1, 18 do
		for j = 1, 18 do
			self.groundTile[i][j]:LoadImage(mapInfo.gTile[i][j],i,j)
			self.wallTile[i][j]:LoadImage(mapInfo.wTile[i][j],i,j)
		end
	end
end

function RGMap:Update(elapsed)
end
