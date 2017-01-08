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


local function call(extra, success, result)
	
	cmd = extra.cmd
	msg = extra.msg
	
	if type(result) == 'boolean' then
		print('This is a old message!')
		txt = "نمیتوانم آن پیام را شناسایی کنم !\nاز پیامی جدیدتر استفاده کنید."
		return reply_msg(msg.id,txt,ok_cb,false)
	end
	
	if success == 0 then
		return send_large_msg(channel, "<i>کاربري با اين نام کاربري يافت نشد !</i>")
	end
	
	-- ban reply
	if cmd == "ban_reply" and not result.action then
		
		user_id = tonumber(result.from.peer_id)
		user_name = string.gsub(result.from.print_name,"_"," ")
		chat_id = tonumber(result.to.peer_id)
		channel = "channel#id"..result.to.peer_id
		
		
		-- Conditional Varibales
		if result.from.username then
			user_username = "@"..result.from.username
		else
			user_username = "----"
		end
		-------------
		
		hash = 'enigma:cli:gpban:'..chat_id
		
		if is_momod2(user_id, chat_id) then
			reply_msg(msg.id,"شما نمیتوانید مدیر ، صاحب و یا مدیر کل را مسدود کنید ... !",ok_cb,false)
			return
		end
		
		if redis:sismember(hash,user_id) then
			kick_user(user_id, chat_id)
			reply_msg(msg.id,"کاربر در حال حاضر مسدود میباشد !\n________\nنام : "..user_name.."\nنام کاربری : "..user_username.."\nآیدی : "..user_id,ok_cb,false)
			return
		else
			redis:sadd(hash,user_id)
			kick_user(user_id, chat_id)
			reply_msg(msg.id,"کاربر مسدود شد !\n________\nنام : "..user_name.."\nنام کاربری : "..user_username.."\nآیدی : "..user_id,ok_cb,false)
			return
		end
		
	end
		
	
	-- banall reply
	if cmd == "banall_reply" and not result.action then	
		
		user_id = tonumber(result.from.peer_id)
		user_name = string.gsub(result.from.print_name,"_"," ")
		chat_id = tonumber(result.to.peer_id)
		hash = 'enigma:cli:gbanned'
		
		-- Conditional Varibales
		if result.from.username then
			user_username = "@"..result.from.username
		else
			user_username = "----"
		end
		-----
		
		if tonumber(user_id) == tonumber(our_id) then
			txt = "نمیتوانید خود ربات را از همه ی گروه ها بن کنید !"
			reply_msg(msg.id,txt,ok_cb,false)
			return
		end
		
		if is_sudo2(user_id) then
			txt = "نمیتوانید یک مدیر کل را از همه ی گروه های بات مسدود کنید !"
			reply_msg(msg.id,txt,ok_cb,false)
			return
		end
		
		if redis:sismember(hash , user_id) then
			txt = "کاربر در حال حاضر از همه ی گروه های بات مسدود میباشد !"
			kick_user(user_id, chat_id)
			reply_msg(msg.id,txt,ok_cb,false)
			return
		else
			txt = "کاربر از همه ی گروه های بات مسدود شد !\n________\nنام : "..user_name.."\nنام کاربری : "..user_username.."\nآیدی : "..user_id
			redis:sadd(hash , user_id)
			kick_user(user_id, chat_id)
			reply_msg(msg.id,txt,ok_cb,false)
			return
		end
		
	end
	
	
	-- ban with username
	if cmd == "ban_username" then

		user_id = tonumber(result.peer_id)
		user_name = string.gsub(result.print_name,"_"," ")
		chat_id = tonumber(msg.to.id)
		
		if is_momod2(user_id, chat_id) then
			txt = "شما نمیتوانید مدیر ، صاحب و یا مدیر کل را مسدود کنید ... !"
			reply_msg(msg.id,txt,ok_cb,false)
			return
		end
		
		hash = 'enigma:cli:gpban:'..msg.to.id
		if redis:sismember(hash,user_id) then
			txt = "کاربر در حال حاضر مسدود میباشد !\n________\nنام : "..user_name.."\nآیدی : "..user_id
			kick_user(user_id, chat_id)
			reply_msg(msg.id,txt,ok_cb,false)
			return
		else
			txt = "کاربر در این گروه مسدود شد !\n________\nنام : "..user_name.."\nآیدی : "..user_id
			redis:sadd(hash,user_id)
			kick_user(user_id, chat_id)
			reply_msg(msg.id,txt,ok_cb,false)
			return
		end
		
	end
	
	-- unban username
	if cmd == "unban_username" and not result.action then
		
		user_id = tonumber(result.peer_id)
		user_name = string.gsub(result.print_name,"_"," ")
		chat_id = tonumber(msg.to.id)
		
		hash = 'enigma:cli:gpban:'..msg.to.id
		if redis:sismember(hash,user_id) then	
			txt = "کاربر رفع مسدودی شد.\nورود او به گروه مجاز شد !\n________\nنام : "..user_name.."\nآیدی : "..user_id
			redis:srem(hash,user_id)
			reply_msg(msg.id,txt,ok_cb,false)
			return
		else
			txt = "این کاربر مسدود نشده است که بخواهد آزاد گردد !\n________\nنام : "..user_name.."\nآیدی : "..user_id
			reply_msg(msg.id,txt,ok_cb,false)
			return
		end
		
	end
	
	-- banall username
	if cmd == "banall_username" then

		user_id = tonumber(result.peer_id)
		user_name = string.gsub(result.print_name,"_"," ")
		user_username = result.username
		
		hash = 'enigma:cli:gbanned'
		if is_sudo2(user_id) then
			txt = "شما نمیتوانید مدیرکل را از همه ی گروه های بات مسدود نمایید !"
			reply_msg(msg.id,txt,ok_cb,false)
			return
		end
		
		if redis:sismember(hash,user_id) then
			txt = "کاربر در حال حاضر از همه ی گروه های بات مسدود میباشد !\n________\nنام : "..user_name.."\nنام کاربری : "..user_username.."\nآیدی : "..user_id
			reply_msg(msg.id,txt,ok_cb,false)
			return
		else
			txt = "کاربر از همه ی گروه های بات مسدود شد !\n________\nنام : "..user_name.."\nنام کاربری : "..user_username.."\nآیدی : "..user_id
			redis:sadd(hash,user_id)
			reply_msg(msg.id,txt,ok_cb,false)
			return
		end

	end
	
	-- silent username
	if cmd == "silent_username" then
	
		user_id = tonumber(result.peer_id)
		user_name = string.gsub(result.print_name,"_"," ")
		user_username = result.username
		chat_id = tonumber(msg.to.id)
		
		hash = 'enigma:cli:mute_user:'..chat_id
		
		if is_momod2(user_id, chat_id) then
			txt = "شما نمیتوانید مدیر ، صاحب و یا مدیر کل را سایلنت کنید ... !"
			reply_msg(msg.id,txt,ok_cb,false)
			return
		end
		
		if tonumber(user_id) == tonumber(our_id) then
			txt = "نمیتوانم خودم را ساکت کنم !"
			reply_msg(msg.id,txt,ok_cb,false)
			return
		end
		
		if redis:sismember(hash,user_id) then
			txt = "چت کاربر آزاد شد !\nهم اکنون میتواند به چت خود ادامه دهد ...\n________\nنام : "..user_name.."\nآیدی : "..user_id
			redis:srem(hash,user_id)
			reply_msg(msg.id,txt,ok_cb,false)
			return
		else
			txt = "کاربر به لیست سایلنت اضافه شد !\nهم اکنون نمیتواند چت کند ...\n________\nنام : "..user_name.."\nآیدی : "..user_id
			redis:sadd(hash,user_id)
			reply_msg(msg.id,txt,ok_cb,false)
			return
		end
		
	end
	
	-- silent reply
	if cmd == "silent_reply" and not result.action then
		
		user_id = tonumber(result.from.peer_id)
		user_name = string.gsub(result.from.print_name,"_"," ")
		chat_id = tonumber(result.to.peer_id)
		
		hash = 'enigma:cli:mute_user:'..chat_id
		
		if is_momod2(user_id, chat_id) then
			txt = "شما نمیتوانید مدیر ، صاحب و یا مدیر کل را سایلنت کنید ... !"
			reply_msg(msg.id,txt,ok_cb,false)
			return
		end
		
		if tonumber(user_id) == tonumber(our_id) then
			txt = "نمیتوان خود ربات را سایلنت کرد"
			reply_msg(msg.id,txt,ok_cb,false)
			return
		end
		
		if redis:sismember(hash,user_id) then
			txt = "چت کاربر آزاد شد !\nهم اکنون میتواند به چت خود ادامه دهد ...\n________\nنام : "..user_name.."\nآیدی : "..user_id
			redis:srem(hash,user_id)
			reply_msg(msg.id,txt,ok_cb,false)
			return
		else
			txt = "کاربر به لیست سایلنت اضافه شد !\nهم اکنون نمیتواند چت کند ...\n________\nنام : "..user_name.."\nآیدی : "..user_id
			redis:sadd(hash,user_id)
			reply_msg(msg.id,txt,ok_cb,false)
			return
		end
	end
		
	-- kick reply
	if cmd == "kick_reply" and not result.action then
	
		user_id = tonumber(result.from.peer_id)
		user_name = string.gsub(result.from.print_name,"_"," ")
		chat_id = tonumber(result.to.peer_id)
		
		-- Conditional Varibales
		if result.from.username then
			user_username = "@"..result.from.username
		else
			user_username = "----"
		end
		-------------
		
		if is_momod2(user_id, chat_id) then
			txt = "شما نمیتوانید مدیر ، صاحب و یا مدیر کل را اخراج کنید ... !"
			reply_msg(msg.id,txt,ok_cb,false)
			return
		end
		
		kick_user(user_id, chat_id)
		reply_msg(msg.reply_id,"کاربر اخراج شد !\n________\nنام : "..user_name.."\nنام کاربری : "..user_username.."\nآیدی :"..user_id,ok_cb,false)
		
	end
	
	-- kick username
	if cmd == "kick_username" then
		
		user_id = tonumber(result.peer_id)
		user_name = string.gsub(result.print_name,"_"," ")
		chat_id = tonumber(msg.to.id)
		
		if is_momod2(user_id, chat_id) then
			reply_msg(msg.id,"شما نمیتوانید مدیر ، صاحب و یا مدیر کل را اخراج کنید ... !",ok_cb,false)
			return nil
		end
		
		kick = kick_user(user_id , chat_id)
			if kick == true then
				text = "کاربر اخراج شد !\n________\nنام : "..user_name.."\nآیدی :"..user_id
			else
				text = "کاربر اخراج نشد!\nکاربر به هر دلیلی اخراج نشد!"
			end
			reply_msg(msg.id,text,ok_cb,false)
		return
	end
	
	---------------------
	
	-- id with reply
	if cmd == "id_reply" and not result.action then
		
		user_id = tonumber(result.from.peer_id)
		user_name = string.gsub(result.from.print_name,'_'," ")
		chat_id = tonumber(result.to.peer_id)
		
		-- Conditional Varibales
		if result.from.username then
			user_username = "@"..result.from.username
		else
			user_username = "----"
		end
		
		text = "💡اطلاعات کاربر مورد نظر :\n________\nنام : "..user_name.."\nنام کاربری : "..user_username.."\nآیدی : "..user_id
		
		return reply_msg(msg.id,text,ok_cb,false)
		
	end	
		
		
	-- id username
	if cmd == "id_username" then
		
		user_id = tonumber(result.peer_id)
		user_name = string.gsub(result.print_name,"_"," ")
		user_username = "@"..(result.username or "----")
		
		text = "💡اطلاعات کاربر مورد نظر :\n________\nنام : "..user_name.."\nنام کاربری : "..user_username.."\nآیدی : "..user_id
		
		return reply_msg(msg.id,text,ok_cb,false)
		
	end
	
	-- idfrom with reply
	if cmd == "idfrom_reply" and not result.action then
		
		user_id = result.fwd_from.peer_id
		user_name = string.gsub(result.fwd_from.print_name,"_"," ")
		
		if result.fwd_from.username then
			user_username = "@"..result.fwd_from.username
		else
			user_username = "----"
		end
		
		text = "💡اطلاعات کاربر فروارد شده :\n________\nنام : "..user_name.."\nنام کاربری : "..user_username.."\nآیدی : "..user_id
		
		return reply_msg(msg.id,text,ok_cb,false)
		
	end



end -- end function

function run(msg,matches) 
	
	
	---------
	data = load_data(_config.moderation.data)
	if data[tostring(msg.to.id)] then
		if data[tostring(msg.to.id)]['settings'] then
			if data[tostring(msg.to.id)]['settings']['lock_cmd'] then
				lock_cmd = data[tostring(msg.to.id)]['settings']['lock_cmd']
				if lock_cmd == "yes" and not is_momod(msg) then
					return
				end
			end
		end
	end
	---------
	
	
	if matches[1] == "ایدی" or matches[1]:lower() == "id" then
		if not matches[2] and not msg.reply_id then 
	
			if msg.to.type == "user" then
		
				user_name = string.gsub(msg.from.print_name, "_", " ")
				user_username = "@"..msg.from.username
				user_link = "TeleGram.Me/"..msg.from.username
			
				if not msg.from.username then
					user_username = "----"
					user_link = "----"
				end
			
				user_id = msg.from.id
			
				return reply_msg(msg.id,"اطلاعات شما : \n\nنام : "..user_name.."\nنام کاربری : "..user_username.."\nآیدی شما : "..user_id.."\nلینک شما : "..user_link.."\n________\n[ @EniGmaTM ]",ok_cb,false)
		
			else
		
				if msg.from.username then
					user = msg.from.username
					txt = "🏷 نام سوپرگروه : " ..msg.to.title.."\n🗝 آیدی سوپرگروه : "..msg.to.id.."\n\n✳️ نام کاربری شما : @"..user.."\n🔅 آیدی عددی شما : "..msg.from.id
				else	
					txt = "🏷 نام سوپرگروه : " ..msg.to.title.."\n🗝 آیدی سوپرگروه : "..msg.to.id.."\n\n🔅 آیدی عددی شما : "..msg.from.id
				end
			
			end
				return reply_msg(msg.id,txt,ok_cb,false)
				
		end
		
	end
	
	
	--- با آیدی عددی ---
	
	-- مسدود کردن یک کاربر با آیدی
	if (matches[1] == "مسدود" or matches[1]:lower() == "ban") and matches[2] and is_momod(msg) then
		if string.match(matches[2],"%d+$") then
			hash = 'enigma:cli:gpban:'..msg.to.id
			user_id = tonumber(matches[2])
			chat_id = msg.to.id
				
			if is_momod2(user_id, chat_id) then
				txt = "نمیتوانید مدیر کل ،مدیر اصلی یا مدیر فرعی را مسدود کنید!\n________\nYou can't ban Sudo,Owner and Moderator !"
				reply_msg(msg.id,txt,ok_cb,false)
				return
			end
				
			if tonumber(user_id) == tonumber(our_id) then
				txt = "خود ربات را نمیتوانید مسدود کنید !\n_______\nI can't ban myself!"
				return reply_msg(msg.id,txt,ok_cb,false)
			end
				
				if redis:sismember(hash,user_id) then
					txt = "کاربر در حال حاضر مسدود میباشد!\n_______\nThis user is already ban!"
					return reply_msg(msg.id,txt,ok_cb,false)
				else
					redis:sadd(hash,user_id)
					kick_user(user_id, chat_id)
					txt = "کاربر مسدود شد!\n_______\n🆔 : "..user_id
					return reply_msg(msg.id,txt,ok_cb,false)
				end
		end
	end
	
	
	-- banall with ID
	if (matches[1] == "مسدود همگانی" or matches[1]:lower() == "banall") and matches[2] and is_sudo(msg) then
		if string.match(matches[2],"%d+$") then
			hash = 'enigma:cli:gbanned'
			user_id = tonumber(matches[2])
			
			if tonumber(user_id) == tonumber(our_id) then
				txt = "نمیتوانید خود ربات را از همه ی گروه ها بن کنید!\n_______\nI can't ban myself From all of my moderated groups!"
				return reply_msg(msg.id,txt,ok_cb,false)
			end
			
			if is_sudo2(user_id) then
				return reply_msg(msg.id,"نمیتوانید سودو را از همه ی گروه ها مسدود کنید!\n_______\nYou can't banall Sudo!",ok_cb,false)
			end
			
			if redis:sismember(hash,user_id) then
				txt = "کاربر با آیدی "..user_id.." در حال حاضر از همه ی گروه های بات مسدود میباشد !"
				return reply_msg(msg.id,txt,ok_cb,false)
			else
				txt = "کاربر با آیدی "..user_id.." از همه ی گروه های بات مسدود شد !"
				redis:sadd(hash,user_id)
				return reply_msg(msg.id,txt,ok_cb,false)
			end
			
		end
		
	end
	
	-- آزاد سازی کاربر با آیدی
	if (matches[1] == "ازاد" or matches[1]:lower() == "unban") and matches[2] and is_momod(msg) then
		if string.match(matches[2],"%d+$") then
			hash = 'enigma:cli:gpban:'..msg.to.id
			user_id = tonumber(matches[2])
			chat_id = msg.to.id
			
			if redis:sismember(hash,user_id) then
				txt = "کاربر از لیست مسدودی ها حذف گردید!\n_______\nUser removed from Banlist"
				redis:srem(hash,user_id)
				return reply_msg(msg.id,txt,ok_cb,false)
			else
				txt = "کاربر مسدود نشده است که بخواهد آزاد گردد!\n_______\nUser is not Banned !"
				return reply_msg(msg.id,txt,ok_cb,false)
			end
		end
	end
	
	-- unbanall with id
	if (matches[1] == "ازاد همگانی" or matches[1]:lower() == "unbanall") and matches[2] and not msg.reply_id and is_momod(msg) then
		if string.match(matches[2],"%d+$") then
		
			hash = 'enigma:cli:gbanned'
			user_id = tonumber(matches[2])
			
			if redis:sismember(hash,user_id) then
				txt = "ورود کاربر به همه ی گروه های بات مجاز شد !"
				redis:srem(hash,user_id)
				return reply_msg(msg.id,txt,ok_cb,false)
			else
				return reply_msg(msg.id,"کاربر از همه ی گروه های بات مسدود نشده است که بخواهد آزاد گردد !",ok_cb,false)
			end
		
		end
		
	end
	
	-- kick with ID
	if (matches[1] == "اخراج" or matches[1]:lower() == "kick") and matches[2] and not msg.reply_id and is_momod(msg) then
		if string.match(matches[2],"%d+$") then
			user_id = tonumber(matches[2])
			chat_id = msg.to.id
			
			if is_momod2(user_id, chat_id) then
				txt = "شما نمیتوانید مدیر ، صاحب و یا مدیر کل را اخراج کنید !"
				return reply_msg(msg.id,txt,ok_cb,false)
			end
			
			if tonumber(user_id) == tonumber(our_id) then
				txt = "من نمیتوانم خودم را اخراج کنم !"
				return reply_msg(msg.id,txt,ok_cb,false)
			end
			
				kick = kick_user(user_id , chat_id)
				if kick == true then
					text = "کاربر اخراج شد !\n________\nآیدی : "..user_id
				else
					text = "کاربر اخراج نشد!\nکاربر به هر دلیلی اخراج نشد!"
				end
				
			return reply_msg(msg.id,text,ok_cb,false)
		end
		
	end
	
	-- Silent SomeOne
	if (matches[1] == "ساکت کردن" or matches[1]:lower() == "silent") and matches[2] and not msg.reply_id and is_momod(msg) then
		if string.match(matches[2],"%d+$") then
			user_id = tonumber(matches[2])
			chat_id = msg.to.id
			hash = 'enigma:cli:mute_user:'..chat_id
			
			if is_momod2(user_id, chat_id) then
				txt = "شما نمیتوانید مدیر ، صاحب و یا مدیر کل را  سایلنت کنید !"
				return reply_msg(msg.id,txt,ok_cb,false)
			end
			
			if tonumber(user_id) == tonumber(our_id) then
				txt = "من نمیتوانم خودم را ساکت کنم!"
				return reply_msg(msg.id,txt,ok_cb,false)
			end
			
			if redis:sismember(hash,user_id) then
				txt = "چت کاربر آزاد شد !\nاو هم اکنون میتواند به گفتگوی خود ادامه دهد.\n________\nآیدی : "..user_id
				redis:srem(hash,user_id)
				return reply_msg(msg.id,txt,ok_cb,false)
			else
				txt = "کاربر به لیست سایلنت اضافه شد !\nهم اکنون نمیتواند چت کند ...\n________\nآیدی : "..user_id
				redis:sadd(hash,user_id)
				return reply_msg(msg.id,txt,ok_cb,false)
			end
		end
	end
	
	
	--- with reply ---
	
	-- ban with reply
	if (matches[1] == "مسدود" or matches[1]:lower() == "ban") and msg.reply_id and is_momod(msg) then
		local res = {
			cmd = "ban_reply",
			msg = msg
		}
			get_message(msg.reply_id, call, res)
	end
	
	-- ban all with reply
	if (matches[1] == "مسدود همگانی" or matches[1]:lower() == "banall") and msg.reply_id and is_momod(msg) then
		local res = {
			cmd = "banall_reply",
			msg = msg
		}
			get_message(msg.reply_id, call, res)
	end
	
	-- kick with reply
	if (matches[1] == "اخراج" or matches[1]:lower() == "kick") and msg.reply_id and is_momod(msg) then
		local res = {
			cmd = "kick_reply",
			msg = msg
		}
			get_message(msg.reply_id, call, res)
	end
	
	-- silent with reply
	if (matches[1] == "ساکت کردن" or matches[1]:lower() == "silent") and msg.reply_id and is_momod(msg) then
		local res = {
			cmd = "silent_reply",
			msg = msg
		}
			get_message(msg.reply_id, call, res)
	end
	
	
	-- id with reply
	if (matches[1] == "ایدی" or matches[1]:lower() == "id") and msg.reply_id and is_momod(msg) then
		local res = {
			cmd = "id_reply",
			msg = msg
		}
			get_message(msg.reply_id, call, res)
	end
	
	
	-- idfrom with reply
	if (matches[1] == "ایدی فروارد" or matches[1]:lower() == "idfrom") and msg.reply_id and is_momod(msg) then
		local res = {
			cmd = "idfrom_reply",
			msg = msg
		}
			get_message(msg.reply_id, call, res)
	end
	
	--- with username ---
	
	-- ban with username
	if (matches[1] == "مسدود" or matches[1]:lower() == "ban") and matches[2] and not msg.reply_id and is_momod(msg) then
		if string.match(matches[2],"@[%a%d]") then
			local username = string.gsub(matches[2],"@","")
			local res = {
				cmd = "ban_username",
				msg = msg
			}
				resolve_username(username , call , res)
		end
	end
	
	-- ازاد با نام کاربری
	if (matches[1] == "ازاد" or matches[1]:lower() == "unban") and matches[2] and not msg.reply_id and is_momod(msg) then
		if string.match(matches[2],"@[%a%d]") then
			local username = string.gsub(matches[2],"@","")
			local res = {
				cmd = "unban_username",
				msg = msg
			}
				resolve_username(username , call , res)
		end
	end
	
	-- banall with username
	if (matches[1] == "مسدود همگانی" or matches[1]:lower() == "banall") and matches[2] and not msg.reply_id and is_sudo(msg) then
		if string.match(matches[2],"@[%a%d]") then
			local username = string.gsub(matches[2],"@","")
			local res = {
				cmd = "banall_username",
				msg = msg
			}
				resolve_username(username , call , res)
		end
	end
	
	-- kick with username
	if (matches[1] == "اخراج" or matches[1]:lower() == "kick") and matches[2] and not msg.reply_id and is_momod(msg) then
		if string.match(matches[2],"@[%a%d]") then
			local username = string.gsub(matches[2],"@","")
			local res = {
				cmd = "kick_username",
				msg = msg
			}
				resolve_username(username , call , res)
		end
	end
	
	-- Silent with username
	if (matches[1] == "ساکت کردن" or matches[1]:lower() == "silent") and matches[2] and not msg.reply_id and is_momod(msg) then
		if string.match(matches[2],"@[%a%d]") then
			local username = string.gsub(matches[2],"@","")
			local res = {
				cmd = "silent_username",
				msg = msg
			}
				resolve_username(username , call , res)
		end
	end
	
	-- id username
	if (matches[1] == "ایدی" or matches[1]:lower() == "id") and matches[2] and not msg.reply_id and is_momod(msg) then
		if string.match(matches[2],"@[%a%d]") then
			local username = string.gsub(matches[2],"@","")
			local res = {
				cmd = "id_username",
				msg = msg
			}
			resolve_username(username, call, res)
		end
	end

	------------------------------------------------------
	-- mute users list
	if (matches[1] == "لیست سکوت" or matches[1]:lower() == "silentlist") and is_momod(msg) then
		hash = redis:smembers('enigma:cli:mute_user:'..msg.to.id)
		text = '🔖 نام گروه : '..msg.to.title.."\n🔇 لیست افراد سایلنت شده :\n________\n"
		for i=1,#hash do
			text = text..i.." - "..hash[i].."\n"
		end
		
			return reply_msg(msg.id,text,ok_cb,false)
	end
	
	-- banlist
	if (matches[1] == "لیست مسدود" or matches[1]:lower() == "banlist") and is_momod(msg) then
		hash = redis:smembers('enigma:cli:gpban:'..msg.to.id)
		text = '⚜ نام گروه : '..msg.to.title.."\n📛 لیست کاربران مسدود شده :\n_________\n"
		for i=1,#hash do
			text = text..i.." - "..hash[i].."\n"
		end
			return reply_msg(msg.id,text,ok_cb,false)
	end
	
	-- Global BanList
	if (matches[1] == "لیست مسدود همگانی" or matches[1]:lower() == "gbanlist") and is_sudo(msg) then
		local hash =  'enigma:cli:gbanned'
		local list = redis:smembers(hash)
		local text = "❌ لیست کسانی که حق ورود به هیج کدامیک از گروه های بات را ندارند :\n\n_________\n"
			for k,v in pairs(list) do
				local user_info = redis:hgetall('user:'..v)
					if user_info and user_info.print_name then
						local print_name = string.gsub(user_info.print_name, "_", " ")
						local print_name = string.gsub(print_name, "‮", "")
						text = text..k.." - "..print_name.." ["..v.."]\n"
					else
			text = text..k.." - "..v.."\n"
					end
			end
		return reply_msg(msg.id,text,ok_cb,false)	
	end
	
	
end -- end function

return {
patterns = {
	
	-- with id and username
	"^(مسدود) (.*)$",
	"^[/!#]([Bb][Aa][Nn]) (.*)$",
	
	"^(مسدود همگانی) (.*)$",
	"^[/!#]([Bb][Aa][Nn][Aa][Ll][Ll]) (.*)$",
	
	"^(ساکت کردن) (.*)$",
	"^[/!#]([Ss][Ii][Ll][Ee][Nn][Tt]) (.*)$",
	
	"^(اخراج) (.*)$",
	"^[/!#]([Kk][Ii][Cc][Kk]) (.*)$",
	
	"^(ازاد) (.*)$",
	"^[/!#]([Uu][Nn][Bb][Aa][Nn]) (.*)$",
	
	"^(ازاد همگانی) (.*)$",
	"^[/!#]([Uu][Nn][Bb][Aa][Nn][Aa][Ll][Ll]) (.*)$",
	
	"^(ایدی) (.*)$",
	"^[/!#]([Ii][Dd]) (.*)$",
	
	-- with reply
	"^(مسدود)$",
	"^[/!#]([Bb][Aa][Nn])$",
	
	"^(اخراج)$",
	"^[/!#]([Kk][Ii][Cc][Kk])$",
	
	"^(مسدود همگانی)$",
	"^[/!#]([Bb][Aa][Nn][Aa][Ll][Ll])$",
	
	"^(ساکت کردن)$",
	"^[/!#]([Ss][Ii][Ll][Ee][Nn][Tt])$",
	
	"^(ایدی)$",
	"^[/!#]([Ii][Dd])$",
	
	"^(ایدی فروارد)$",
	"^[/!#]([Ii][Dd][Ff][Rr][Oo][Mm])$",
	
	-- lists
	"^(لیست مسدود)$",
	"^[/!#]([Bb][Aa][Nn][Ll][Ii][Ss][Tt])$",
	
	"^(لیست مسدود همگانی)$",
	"^[/!#]([Gg][Bb][Aa][Nn][Ll][Ii][Ss][Tt])$",
	
	"^(لیست سکوت)$",
	"^[/!#]([Ss][Ii][Ll][Ee][Nn][Tt][Ll][Ii][Ss][Tt])$",
	
	"^(ایدی)$",
	"^[/!#]([Ii][Dd])$"
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