require "go.ui.control.StaticImage"
require "go.ui.sound.Sound"

class 'CharAnimation'

function CharAnimation:__init(name, char)
	self.name = name
	self.char = char				-- 애니메이션이 소속된 케릭정보
	self.loop = false				-- 반복여부
	self.delayPerFrame = 0.15		-- 프레임당 플레이 시간   
	self.offset = Vector2(0, 0)		-- 케릭터포지션(character.pos)에서 떨어진 거리(Image는 좌상단 좌표를 기준으로 하므로)
	
	self.frame = {}					-- 프레임 테이블
	self:Reset()	
end

function CharAnimation:Reset()
	for i=1, #self.frame do
		self.frame[i]:Show(false)
	end
	self.frameNo = 0
	self.playtime = -0.0001
end

function CharAnimation:SetOffset(x, y)
	self.offset = Vector2(x, y)
end

function CharAnimation:SetLoop(loop)
	if loop == nil then return end
	self.loop = loop
end

function CharAnimation:SetDelay(delay)
	self.delayPerFrame = delay
end

function CharAnimation:AddFrame(filename, sound)
	local id = #self.frame+1
	
	local frame = StaticImage()
	Scene.latestScene:AddChild(frame)	
	frame:LoadStaticImage(filename, 1, 1, nil, UIConst.Black)
	frame:Show(false)
	frame.sound = sound

	self.frame[id] = frame

	return frame
end

function CharAnimation:ChangeImg(frame_id, filename)
	self.frame[frame_id]:LoadStaticImage(filename, 1, 1, nil, UIConst.Black)
end

function CharAnimation:BringToTop()
	for i = 1,#self.frame do
		self.frame[i]:BringToTop()
	end
end

function CharAnimation:NextFrame(elapsed)
	local frameNo = math.floor((self.playtime+elapsed)/self.delayPerFrame)+1
	if frameNo > self.frameNo then
		self.frameNo = self.frameNo+1
 		frameNo = self.frameNo
	end

	if frameNo <= #self.frame then
		if self.frame[frameNo-1] then
			self.frame[frameNo-1]:Show(false)
		end
		if self.frame[frameNo] then
			local x = self.char.pos.x - self.offset.x
 			local y = self.char.pos.y - self.offset.y
			self.frame[frameNo]:SetXYPos(x, y)
 			--self.frame[frameNo]:SetFlip(self.char.flipImg, false)
			self.frame[frameNo]:Show(true)
		else
			print("error! frame missing : ", frameNo)
		end
	elseif self.loop then
		self:Reset()
		self:NextFrame(elapsed)
	else
		self.char:OnAnimationEnd(elapsed)
	end
end

function CharAnimation:UpdateSound()
	local frame = self.frame[self.frameNo]
	if frame == nil then return nil end
	if frame.sound == nil then return nil end
	frame.sound:PlaySound()
end

function CharAnimation:Update(elapsed)
	self:NextFrame(elapsed)
	self:UpdateSound()

	self.playtime = self.playtime + elapsed
end