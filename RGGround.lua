class 'RGGround'

function RGGround:__init()
	self.frame = StaticImage()
	Scene.latestScene:AddChild(self.frame)
	self.frame:Show(false)
end

function RGGround:LoadImage(index,i,j)
	if index == -1 then
		self.frame:Show(false)
		return
	else
		self.frame:Show(true)
	end

	self.frame:LoadStaticImage("images/ground.png", 5, 4, nil, nil)
	self.frame:SetStaticImageIndex(index)

	self:SetXYPos(MAP_LEFT_OFFSET+(i-1)*32, (j-1)*32 + MAP_TOP_OFFSET)
end

function RGGround:SetXYPos(x, y)
	if not self.frame then return
	end
	self.frame:SetXYPos(x, y)
end
