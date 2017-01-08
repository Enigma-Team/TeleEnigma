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

sudo_id = _config.sudo_users[1]
Sudo = "user#id"..sudo_id

--Get and output info about supergroup
local function callback_info(cb_extra, success, result)
	local title ="✅ تاییدیه ی ورود به سوپرگروه\n________\n👥 نام سوپر گروه : "..result.title.."\n"
	local channel_id = "🗝 آیدی سوپرگروه : "..result.peer_id..'\n'
	local user_num = "🗣 تعداد کاربران : "..result.participants_count.."\n"
	
	local text = title..channel_id..user_num
		send_large_msg(Sudo, text)
end

local function run(msg,matches)
	
	rec = get_receiver(msg)
	
	bot_id = tonumber(our_id)
	
	if msg.service then
		action = msg.action.type
		if action == "chat_add_user_link" then
			if tonumber(msg.from.id) == 0 then
			
				if msg.to.type == "channel" then
					return channel_info(rec, callback_info, {receiver = rec, msg = msg})
				end
				
				gp_name = msg.to.title
				gp_id = msg.to.id
				
				txt = "✅ تاییدیه ی ورود به گروه\n________\nنام گروه : "..gp_name.."\nآیدی گروه : "..gp_id
				
				send_large_msg(Sudo,txt)
				
			end
		end
		
		if action == "chat_del_user" then
			id = tonumber(msg.action.user.id)
			
			gp_name = msg.to.title
			gp_id = msg.to.id
			
			rem_name = string.gsub(msg.from.print_name,"_"," ")
			rem_id = msg.from.id
			rem_username = "@"..(msg.from.username or "None")
			
			if msg.to.type == "channel" then
				gp_type = "سوپرگروه"
				
			elseif msg.to.type == "chat" then
				gp_type = "گروه عادی"
				
			end
			
			txt = "من از یک گروه اخراج شدم !\n_________\nاطلاعات گروه : \n\nنام : "..gp_name..'\nآیدی : '..gp_id..'\nنوع گروه : '..gp_type..'\n------\nاطلاعات فرد اخراج کننده :\n\nنام : '..rem_name..'\nآیدی : '..rem_id..'\nیوزرنیم : '..rem_username
			
			if id == bot_id then
				send_large_msg(Sudo,txt)
			end
			
		end
		
	end
-------------
end -- end function

return {
patterns = {
	"^!!tgservice (chat_add_user_link)$",
	"^!!tgservice (chat_del_user)$",
},
	run = run
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