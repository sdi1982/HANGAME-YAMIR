class 'RGWall'

function RGWall:__init()
	self.index = -1
	self.frame = StaticImage()
	self.pos = Vector2(0,0)
	self.offset = Vector2(0,0)
	
	Scene.latestScene:AddChild(self.frame)
	self.frame:Show(false)
end

function RGWall:SetXYPos(x, y)
	if not self.frame then return
	end

--	local x = self.pos.x - self.offset.x
--	local y = self.pos.y - self.offset.y

	self.frame:SetXYPos(x, y)
end

function RGWall:LoadImage(index, i, j)
	self.index = index
	
	if index == -1 then
		self.frame:Show(false)
		return
	elseif 0 <= index and index <= 99 then
		self.frame:LoadStaticImage("images/wall.png", 7, 1, nil, nil)
		self.frame:SetStaticImageIndex(index)
		self:SetXYPos(MAP_LEFT_OFFSET+(i-1)*32, (j-1)*32 + MAP_TOP_OFFSET - 8)

	elseif 100 <= index and index <= 200 then
		self.frame:LoadStaticImage("images/tree.png", 20, 1, nil, UIConst.Black)
		index2 = index%100
		self.frame:SetStaticImageIndex(index2)
		self:SetXYPos(MAP_LEFT_OFFSET+(i-1)*32, (j-1)*32 + MAP_TOP_OFFSET - 48)
	end

	self.frame:Show(true)
end

function RGWall:BringToTop()
	self.frame:BringToTop()
end

function RGWall:IsShown()
	self.frame:IsShown()
end

function RGWall:SetOffest(x, y)
	self.offset = Vector2(x, y)
end