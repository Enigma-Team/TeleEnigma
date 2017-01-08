--[[

	Powered By :
		 _____       _  ____
		| ____|_ __ (_)/ ___|_ __ ___   __ _ TM
		|  _| | '_ \| | |  _| '_ ` _ \ / _` |
		| |___| | | | | |_| | | | | | | (_| |
		|_____|_| |_|_|\____|_| |_| |_|\__,_|
	
	****************************
	*  >> By : Reza Mehdipour  *
	*  > Channel : @EnigmaTM   *
	****************************
	
]]


-- Group Expired Text in Persian ...
GroupExpiredText = [[
🚫 نمیتوانید از این دستور استفاده کنید .
◀️ دلیل : شارژ گروه تمام شده است.
💠 برای اطلاعات بیشتر این را بفرستید :
👉 /helpcharge
]]

-- Group Charge Left Text in Persian ...
ChargeLeftText = [[
🚫 مدت زمان کمی از شارژ گروه باقی مانده .
💠 برای دریافت روش تمدید این را بفرستید :
👈 راهنمای شارژ

💥 شارژ باقی مانده :
]]

-- Expire Not Set Text in Persian ..
ExpireNotSetText = [[
⭕️ شارژ گروه تنظیم نشده است.
]]


-- SUDO ID
BotSudoID = _config.sudo_users[1]


local function run(msg,matches)

if (matches[1] == 'شارژ' or matches[1]:lower() == "charge") and matches[2] and is_sudo(msg) then
	if redis:hget('expires0',msg.to.id) then redis:del('expires0', msg.to.id) end
	if redis:hget('expires1',msg.to.id) then redis:del('expires1', msg.to.id) end
	if redis:hget('expires2',msg.to.id) then redis:del('expires2', msg.to.id) end
	if redis:hget('expires3',msg.to.id) then redis:del('expires3', msg.to.id) end
	if redis:hget('expires4',msg.to.id) then redis:del('expires4', msg.to.id) end
	if redis:hget('expires0',msg.to.id) then redis:del('expires5', msg.to.id) end
		local time = os.time()
		local buytime = tonumber(os.time())
		local timeexpire = tonumber(buytime) + (tonumber(matches[2]) * 86400)
		redis:hset('expiretime',get_receiver(msg),timeexpire)
		return "✅ گروه "..msg.to.title.." شارژ شد برای : "..matches[2].." روز"
	end

	-- Charge From Out Of GROUP
	if matches[1] == 'charges' and is_sudo(msg) then
		local group = 'channel#id'..matches[2]
		if redis:hget('expires0',group) then redis:del('expires0',group) end
		if redis:hget('expires1',group) then redis:del('expires1',group) end
		if redis:hget('expires2',group) then redis:del('expires2',group) end
		if redis:hget('expires3',group) then redis:del('expires3',group) end
		if redis:hget('expires4',group) then redis:del('expires4',group) end
		if redis:hget('expires0',group) then redis:del('expires5',group) end
			local time = os.time()
			local buytime = tonumber(os.time())
			local timeexpire = tonumber(buytime) + (tonumber(matches[3]) * 86400)
				redis:hset('expiretime',group,timeexpire)
	return "✅ گروه "..group.." برای "..matches[3].. " روز با موفقیت شارژ شد. ✅"
end

if (matches[1] == "راهنمای شارژ" or matches[1]:lower() == "helpcharge") and is_momod(msg) then

	local data = load_data(_config.moderation.data)
	local target = 1070973134 -- ایدی گروه پشتیبانی
	Link = data[tostring(target)]['settings']['set_link']
	
	if Link then
		SpLink = Link
	else
		SpLink = "لینک موجود نیست."
	end
	
	HelpChargeText = [[جهت شارژ گروه خود از طریق ربات زیر با ما در تماس باشید :
@EnigmaSupBot
➖➖➖➖
یا در گروه پشتیبانی عضو شوید :]]
	return reply_msg(msg.id,HelpChargeText.."\n"..SpLink,ok_cb,false)
end

end -- end run function

-------------------- Start [C H A R G E] Plugin -----------------------------
local function pre_process(msg)

		if msg.to.type == "channel" then
			local data = load_data(_config.moderation.data)
			local timetoexpire = 'unknown'
			local expiretime = redis:hget('expiretime', get_receiver(msg))
			local now = tonumber(os.time())

		if data[tostring(msg.to.id)] then
		
			-- group owner
			if data[tostring(msg.to.id)]['set_owner'] then
				GpOwner = tonumber(data[tostring(msg.to.id)]['set_owner'])
			else
				GpOwner = 0
			end
		
			-- group link
			if data[tostring(msg.to.id)]['settings']['set_link'] then
				GpLink = data[tostring(msg.to.id)]['settings']['set_link']
			else
				GpLink = "[None]"
			end
		end

		if expiretime then    
			timetoexpire = math.floor((tonumber(expiretime) - tonumber(now)) / 86400) + 1
			if tonumber("0") > tonumber(timetoexpire) then
				-- When Group Expired Do :
				local data = load_data(_config.moderation.data)
				send_large_msg(get_receiver(msg),GroupExpiredText)
				send_large_msg("user#id"..GpOwner,"مدیر گرامی ، سلام\n\n🚫 شارژ گروه شما با نام "..msg.to.title.." تمام شده است. بات از آن گروه خارج شد.\n\n👈 برای تمدید ربات در گروهتان با ما در ارتباط باشید\n☑️ ☑️ در صورتی که ریپورتید به گروه پشتیبانی مراجعه کنید :\n> https://telegram.me/joinchat/DAXPpz_VwM5azabRHkmmBg")
			
				-- rem group
				hashes = 'mute_user:'..msg.to.id
				redis:del(hashes)
				save_data(_config.moderation.data, data)
				------------
			
			if redis:hget('expires0',msg.to.id) then redis:del('expires0', msg.to.id) end
			if redis:hget('expires1',msg.to.id) then redis:del('expires1', msg.to.id) end
			if redis:hget('expires2',msg.to.id) then redis:del('expires2', msg.to.id) end
			if redis:hget('expires3',msg.to.id) then redis:del('expires3', msg.to.id) end
			if redis:hget('expires4',msg.to.id) then redis:del('expires4', msg.to.id) end
			if redis:hget('expires0',msg.to.id) then redis:del('expires5', msg.to.id) end
				send_large_msg("user#id"..BotSudoID, "شارژ یک گروه به پایان رسید !\n___________\n> نام گروه : "..msg.to.title.."\n> مدیر اصلی بات در گروه : "..GpOwner.."\n> آیدی گروه : "..msg.to.id.."\n> لینک گروه : "..GpLink.."\n___________\nدستور خروج : خروج "..msg.to.id.."\n#Charge Command : /charges "..msg.to.id.." 5")
				leave_channel(get_receiver(msg), ok_cb, false)
			end
			
	if tonumber(timetoexpire) == 0 then
		if redis:hget('expires0',msg.to.id) then return msg end
		send_large_msg(get_receiver(msg), ChargeLeftText..' 0 روز (آخرین روز)')
		redis:hset('expires0',msg.to.id,'5')
	end
	if tonumber(timetoexpire) == 1 then
		if redis:hget('expires1',msg.to.id) then return msg end
		send_large_msg(get_receiver(msg), ChargeLeftText..' 1 روز')
		redis:hset('expires1',msg.to.id,'5')
	end
	if tonumber(timetoexpire) == 2 then
		if redis:hget('expires2',msg.to.id) then return msg end
		send_large_msg(get_receiver(msg), ChargeLeftText..' 2 روز')
		redis:hset('expires2',msg.to.id,'5')
	end
	if tonumber(timetoexpire) == 3 then
		if redis:hget('expires3',msg.to.id) then return msg end
		send_large_msg(get_receiver(msg), ChargeLeftText..' 3 روز')
		redis:hset('expires3',msg.to.id,'5')
	end
	if tonumber(timetoexpire) == 4 then
		if redis:hget('expires4',msg.to.id) then return msg end
		send_large_msg(get_receiver(msg), ChargeLeftText..' 4 روز')
		redis:hset('expires4',msg.to.id,'5')
	end
	if tonumber(timetoexpire) == 5 then
		if redis:hget('expires5',msg.to.id) then return msg end
		send_large_msg(get_receiver(msg), ChargeLeftText..' 5 روز')
		redis:hset('expires5',msg.to.id,'5')
	end
end

end -- end msg.to.type == "channel"

	return msg

end -- end pre_process(msg)
-------------------- End [C H A R G E] Plugin -------------------


return {
patterns = {
	"^(شارژ) (.*)$",
	"^[/!#]([Cc][Hh][Aa][Rr][Gg][Ee])$",
	
	"^[#!/]([Cc]harges) (%d+) (.*)$",
	
	"^(راهنمای شارژ)$",
	"^[/!#]([Hh][Ee][Ll][Pp][Cc][Hh][Aa][Rr][Gg][Ee])$",
},
	run = run,
	pre_process = pre_process
}


--[[

	Powered By :
		 _____       _  ____
		| ____|_ __ (_)/ ___|_ __ ___   __ _ TM
		|  _| | '_ \| | |  _| '_ ` _ \ / _` |
		| |___| | | | | |_| | | | | | | (_| |
		|_____|_| |_|_|\____|_| |_| |_|\__,_|
	
	****************************
	*  >> By : Reza Mehdipour  *
	*  > Channel : @EnigmaTM   *
	****************************
	
]]
