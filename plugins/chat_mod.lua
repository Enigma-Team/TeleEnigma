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

-----------------------------------------------------------------

-- /add function
local function check_member_super(cb_extra, success, result)
	local receiver = cb_extra.receiver
	local data = cb_extra.data
	local msg = cb_extra.msg
		if type(result) == 'boolean' then
			print('This is a old message!')
			return reply_msg(msg.id, 'این پیام قدیمی است!', ok_cb, false)
		end
		
	if success == 0 then
		send_large_msg(receiver, "ابتدا مرا در گروه ادمین کنید !")
	end
	
		for k,v in pairs(result) do
			local member_id = v.peer_id
				if member_id ~= our_id then
					-- SuperGroup configuration
					data[tostring(msg.to.id)] = {
						group_type = 'SuperGroup',
							long_id = msg.to.peer_id,
							moderators = {},
							set_owner = member_id ,
							settings = {
								set_name = string.gsub(msg.to.title, '_', ' '),
								
								------- G E N E R A L Locks --------
								lock_link = "no",
								lock_forward = 'no',
								lock_inline = 'no',
								lock_cmd = 'no',
								lock_english = 'no',
								lock_arabic = 'no',
								lock_spam = 'yes',
								flood = 'yes',
								lock_bots = 'no',
								lock_tgservice = 'yes',
								strict = 'no',
								
								-------- M E D I A Locks ---------
								lock_audio = 'no',
								lock_photo = 'no',
								lock_video = 'no',
								lock_documents = 'no',
		 						lock_text = 'no',
								lock_gifs = 'no',
								lock_sticker = 'no',
								lock_contacts = 'no',
								lock_all = 'no',
								
								-------- Other ----------
								lock_wlc = 'no',
		}
	}
		save_data(_config.moderation.data, data)
			local groups = 'groups'
			if not data[tostring(groups)] then
				data[tostring(groups)] = {}
				save_data(_config.moderation.data, data)
			end
		data[tostring(groups)][tostring(msg.to.id)] = msg.to.id
		save_data(_config.moderation.data, data)
			local text = 'سوپر گروه به لیست گروه های مدیریتی بات اضافه گردید !\n________\nنام گروه : '..msg.to.title..'\nآیدی گروه : '..msg.to.id
	return reply_msg(msg.id, text, ok_cb, false)

				end
		end
end

--Function to Add supergroup
local function superadd(msg)
	local data = load_data(_config.moderation.data)
	local receiver = get_receiver(msg)
    channel_get_users(receiver, check_member_super,{receiver = receiver, data = data, msg = msg})
end

--------------------

-- /rem function
local function check_member_superrem(cb_extra, success, result)
	local receiver = cb_extra.receiver
	local data = cb_extra.data
	local msg = cb_extra.msg
		if type(result) == 'boolean' then
			print('This is a old message!')
			return reply_msg(msg.id, 'این یک پیام قدیمی میباشد ، بات توانایی خواندن آن را ندارد !', ok_cb, false)
		end
	for k,v in pairs(result) do
		local member_id = v.id
			if member_id ~= our_id then
				-- Group configuration removal
				data[tostring(msg.to.id)] = nil
				save_data(_config.moderation.data, data)
				local groups = 'groups'
					if not data[tostring(groups)] then
						data[tostring(groups)] = nil
						save_data(_config.moderation.data, data)
					end
				data[tostring(groups)][tostring(msg.to.id)] = nil
				save_data(_config.moderation.data, data)
					local text = 'سوپرگروه از لیست گروه های مدیریت شده ی بات حذف گردید !\n________\nنام گروه : '..msg.to.title..'\nآیدی گروه : '..msg.to.id
		return reply_msg(msg.id, text, ok_cb, false)
			end

	end

end

--Function to remove supergroup
local function superrem(msg)
	local data = load_data(_config.moderation.data)
	local receiver = get_receiver(msg)
	channel_get_users(receiver, check_member_superrem,{receiver = receiver, data = data, msg = msg})
end

-------------------------

-- Get and output admins in supergroup
local function group_admin_list(cb_extra, success, result)
	
	msg = cb_extra.msg
	
	local i = 1
	local chat_name = string.gsub(cb_extra.msg.to.print_name, "_", " ")
	local member_type = cb_extra.member_type
	local text = "🔅 نام گروه : "..chat_name.."\n👤 لیست ادمین های گروه :\n__________"
		for k,v in pairsByKeys(result) do
			if not v.first_name then
				name = " "
			else
				vname = v.first_name:gsub("‮", "")
				name = vname:gsub("_", " ")
			end
	text = text.."\n"..i.." - "..name.." ["..v.peer_id.."]"
	i = i + 1
		end
		
		return reply_msg(msg.id,text,ok_cb,false)
end

--------------

-- get and output api robots in Group
local function get_bots_list(cb_extra, success, result)
	local msg = cb_extra.msg
	local i = 1
	local chat_name = msg.to.title
	local member_type = cb_extra.member_type
	local text = "🔖 نام گروه : "..chat_name.."\n🤖 لیست بات های معمولی موجود در گروه :\n________\n"
		for k,v in pairsByKeys(result) do
			if not v.first_name then
				bot_name = " "
			else
				vname = v.first_name:gsub("‮", "")
				bot_name = vname:gsub("_", " ")
			end
			
			if not v.username then
				bot_username = ""
			else
				bot_username = "@"..v.username
			end
			
	text = text.."\n"..i.." - "..bot_name.." ("..bot_username..") ["..v.peer_id.."]"
		i = i + 1
		end
		
		return reply_msg(msg.id,text,ok_cb,false)
end
---------------

-- فانکشن حذف تمامی بات ها از گروه
local function callback_clean_bots(extra, success, result)
	local msg = extra.msg
	local receiver = 'channel#id'..msg.to.id
	local channel_id = msg.to.id
	local i = 0
	for k,v in pairs(result) do
		local bot_id = v.peer_id
		kick_user(bot_id,channel_id)
		i = i + 1
	end
	
	return reply_msg(msg.id,"<b>"..i.."</b> بات از گروه اخراج شدند ...",ok_cb,false)
end
---------------

-- فانکشن حذف اکانت های حذف شده از گروه
local function check_member_super_deleted(cb_extra, success, result)
	local receiver = cb_extra.receiver
	local msg = cb_extra.msg
	local deleted = 0 
	if success == 0 then
		send_large_msg(receiver, "ابتدا مرا ادمین کنید !") 
	end
	for k,v in pairs(result) do
		if not v.first_name and not v.last_name then
			deleted = deleted + 1
			kick_user(v.peer_id,msg.to.id)
		end
	end
		send_large_msg(receiver, "<b>"..deleted.."</b> اکانت حذف شده ، از گروه اخراج شدند ...") 
end

---------------
--Get and output info about supergroup
local function callback_info(cb_extra, success, result)
	
	msg = cb_extra.msg
	
	local title ="👥 نام سوپر گروه : "..result.title.."\n"
	local channel_id = "🗝 آیدی سوپرگروه : "..result.peer_id.."\n\nاطلاعات اصلی گروه :\n________\n"
	local admin_num = "👤 تعداد مدیران : "..result.admins_count.."\n"
	local user_num = "🗣 تعداد کاربران : "..result.participants_count.."\n"
	local kicked_num = "❌ تعداد کاربران بلاک شده : "..result.kicked_count.."\n"
		if result.username then
			channel_username = "🔢 یوزرنیم : @"..result.username
		else
			channel_username = ""
		end
	local text = title..channel_id..admin_num..user_num..kicked_num..channel_username
		
		return reply_msg(msg.id,text,ok_cb,false)
end
--------------------------
-- get modlist
local function modlist(msg)

	local data = load_data(_config.moderation.data)
	local groups = "groups"
	
	if not data[tostring(groups)][tostring(msg.to.id)] then
		return 'سوپرگروه اضافه نشده است'
	end
	
	-- determine if table is empty
	if next(data[tostring(msg.to.id)]['moderators']) == nil then
		return 'لیست مدیران فرعی بات در گروه خالی میباشد !\n________\nاین بدان معناست که کسی به عنوان مدیر فرعی تایین نشده است.'
	end
	
	local i = 1
	local message = '\n🏷 نام گروه : ' .. string.gsub(msg.to.print_name, '_', ' ') .. '\n🔰 مدیران فرعی بات در گروه :\n________\n'
	for k,v in pairs(data[tostring(msg.to.id)]['moderators']) do
		message = message ..i..' - '..v..' [' ..k.. '] \n'
		i = i + 1
	end
		message = message:gsub("(at)","@")
	return reply_msg(msg.id,message,ok_cb,false)
end
----------------------------
--'Set supergroup photo' function
local function set_supergroup_photo(msg, success, result)
	local data = load_data(_config.moderation.data)
	if not data[tostring(msg.to.id)] then
		return
	end
	local receiver = get_receiver(msg)
	if success then
		local file = './data/photos/channel_photo_'..msg.to.id..'.jpg'
		print('File downloaded to:', result)
		os.rename(result, file)
		print('File moved to:', file)
		channel_set_photo(receiver, file, ok_cb, false)
		data[tostring(msg.to.id)]['settings']['set_photo'] = file
		save_data(_config.moderation.data, data)
		send_large_msg(receiver, 'تصویر گروه به تصویر جدید تنظیم شد.', ok_cb, false)
	else
		print('Error downloading: '..msg.id)
		send_large_msg(receiver, 'تنظیم کردن با مشکلی برخورد ! دوباره امتحان کنید.', ok_cb, false)
	end
end
----------------------------------------------------------------------------------------------------

-----------------------

local function promote(receiver, user_first ,member_username, user_id)
	
	local data = load_data(_config.moderation.data)
	local group = string.gsub(receiver, 'channel#id', '')
	
	if not data[group] then
		return send_large_msg(receiver, 'این سوپرگروه اضافه نشده است!')
	end
	
	if data[group]['moderators'][tostring(user_id)] then
		return send_large_msg(receiver, 'کاربر '..user_first..'\nدر حال حاضر یک مدیر فرعی برای ربات در گروه می باشد')
	end
	
	if tonumber(user_id) == tonumber(our_id) then
		txt = "نمیتوان خود ربات را ترفیع داد!"
		return send_large_msg(receiver,txt)
	end
	
	if is_owner2(user_id, group) then
		return send_large_msg(receiver, 'کاربر '..user_first..'\nدر حال حاضر مقامی بیشتر از مدیر فرعی را داراست و نیازی به ارتقا به مدیر فرعی ندارد!')
	end
	
	data[group]['moderators'][tostring(user_id)] = member_username
	save_data(_config.moderation.data, data)
	send_large_msg(receiver, 'کاربر '..user_first..'\nبه لیست مدیران فرعی بات در گروه اضافه گردید.\n________\nاکنون او میتواند بات را در 90درصد موارد در گروه هدایت کند.')
end

-- demote function
local function demote(chat_id , user_name ,user_id)

	local data = load_data(_config.moderation.data)
	rec = "channel#id"..chat_id
	chat_id = tostring(chat_id)
	user_id = tostring(user_id)
	
	if data[chat_id] then
		if data[chat_id]["moderators"] then
			if data[chat_id]["moderators"][user_id] then
				data[chat_id]["moderators"][user_id] = nil
				save_data(_config.moderation.data, data)
				txt = "کاربر "..user_name.."\nاز مدیریت فرعی ربات در گروه عزل گردید!"
				return send_large_msg(rec,txt)
			else
				txt = "کاربر "..user_name..'\nمدیر فرعی نبوده است که بخواهد عزل گردد.'
				return send_large_msg(rec,txt)
			end
		else
			txt = "لیست مدیریت این گروه خالی میباشد!\nمدیر فرعی وجود ندارد که بخواهد عزل شود."
			return send_large_msg(rec,txt)
		end
	else
		txt = "این گروه اضافه نشده است!"
		return send_large_msg(rec,txt)
	end

end
	
	

local function set(extra, success, result)
	
	local msg = extra.msg
	local cmd = extra.cmd
	local data = load_data(_config.moderation.data)
	local our_id = tonumber(our_id)
	local rec = "channel#id"..msg.to.id
	
	if type(result) == 'boolean' then
		print('This is a old message!')
		txt = "نمیتوانم آن پیام را شناسایی کنم !\nاز پیامی جدیدتر استفاده کنید."
		return reply_msg(msg.id,txt,ok_cb,false)
	end
	
	-- set owner with reply
	if cmd == "setowner_reply" and not result.action then
		
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
		
		if user_id == our_id then
			txt = "نمیتوان خود ربات را مدیر اصلی کرد."
			return reply_msg(msg.id,txt,ok_cb,false)
		end
		
		if data[tostring(msg.to.id)]['set_owner'] then
			owner = tonumber(data[tostring(msg.to.id)]['set_owner'])
			if owner == user_id then
				txt = "کاربر "..user_name.."\nدر حال حاضر مدیر اصلی ربات در گروه میباشد."
				return reply_msg(msg.id,txt,ok_cb,false)
			end
		end
		
		data[tostring(msg.to.id)]['set_owner'] = tostring(result.from.peer_id)
		save_data(_config.moderation.data, data)
			
		txt = "کاربر مورد نظر به عنوان مدیر اصلی ربات در این گروه تنظیم شد.\n________\nنام : "..user_name.."\nیوزرنیم : "..user_username.."\nآیدی : "..user_id
			
			return reply_msg(msg.id,txt,ok_cb,false)
	end
	
	-- set owner with username
	if cmd == "setowner_username" and not result.action then
		
		user_id = tonumber(result.peer_id)
		user_name = string.gsub(result.print_name,"_"," ")
		chat_id = tonumber(msg.to.id)
		
		if user_id == our_id then
			txt = "نمیتوان خود ربات را مدیر اصلی کرد."
			return reply_msg(msg.id,txt,ok_cb,false)
		end
		
		if data[tostring(msg.to.id)]['set_owner'] then
			owner = tonumber(data[tostring(msg.to.id)]['set_owner'])
			if owner == user_id then
				txt = "کاربر "..user_name.."\nدر حال حاضر مدیر اصلی ربات در گروه میباشد."
				return reply_msg(msg.id,txt,ok_cb,false)
			end
		end
		
		data[tostring(msg.to.id)]['set_owner'] = tostring(result.peer_id)
		save_data(_config.moderation.data, data)
		
		txt = "کاربر مورد نظر به عنوان مدیر اصلی ربات در این گروه تنظیم شد.\n________\nنام : "..user_name.."\nآیدی : "..user_id
			
			return reply_msg(msg.id,txt,ok_cb,false)
		
	end
	
	
	-- promote with reply
	if cmd == "promote_reply" and not result.action then
		
		user_id = tonumber(result.from.peer_id)
		user_first = string.gsub(result.from.print_name,"_"," ")
		chat_id = tonumber(result.to.peer_id)
		rec = "channel#id"..result.to.peer_id
		
		-- Conditional Varibales
		if result.from.username then
			user_username = "@"..result.from.username
		else
			user_username = "@None"
		end
		-------------
		
		return promote(rec, user_first, user_username, result.from.peer_id)
		
	end
	
	-- promote with username
	if cmd == "promote_username" and not result.action then
		
		user_id = tonumber(result.peer_id)
		user_first = string.gsub(result.print_name,"_"," ")
		user_username = result.username
		chat_id = tonumber(msg.to.id)
		rec = "channel#id"..msg.to.id
		
		return promote(rec , user_first, user_username, result.peer_id)
		
	end
	
	-----------------
	
	-- demote with reply
	if cmd == "demote_reply" and not result.action then
		
		user_id = result.from.peer_id
		user_first = string.gsub(result.from.print_name,"_"," ")
		chat_id = result.to.peer_id
		rec = "channel#id"..result.to.peer_id
		
		-- Conditional Varibales
		if result.from.username then
			user_username = "@"..result.from.username
		else
			user_username = "@None"
		end
		-------------
		
		return demote(chat_id,user_first,user_id)
		
	end
	
	-- demote with username
	if cmd == "demote_username" and not result.action then
		
		user_id = result.peer_id
		user_first = string.gsub(result.print_name,"_"," ")
		user_username = result.username
		chat_id = msg.to.id
		rec = "channel#id"..msg.to.id
		
		return demote(chat_id,user_first,user_id)
		
	end
	
end

--------------------------------------  R U N Function ---------------------------------------------
function run(msg,matches)
	
if msg.to.type == "channel" then
	
	-- varibales
	local rec = get_receiver(msg)
	
	------- LOCK CMD
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
	-------
	
	-- نصب سوپرگروه
	if (matches[1] == 'نصب' or matches[1]:lower() == "add") and not matches[2] and is_sudo(msg) then
		if is_super_group(msg) then
			txt = "این سوپرگروه در حال حاضر در لیست گروه های مدیریت شده ی ربات قرار دارد.\n________\nنام : "..msg.to.title.."\nآیدی : "..msg.to.id
			return reply_msg(msg.id,txt,ok_cb,false)
		end
		superadd(msg)
	end
	---------------
	
	-- حذف سوپرگروه
	if (matches[1] == 'لغو نصب' or matches[1]:lower() == "rem") and not matches[2] and is_sudo(msg) then
		if not is_super_group(msg) then
			txt = "این سوپرگروه به لیست مدیریتی ربات اضافه نشده است!"
			return reply_msg(msg.id,txt,ok_cb,false)
		end
		
		mute_hash = 'enigma:cli:mute_user:'..msg.to.id
		ban_hash = "enigma:cli:gpban:"..msg.to.id
		FilterHash = "enigma:cli:filtered:"..msg.to.id
		redis:del(FilterHash)
		redis:del(mute_hash)
		redis:del(ban_hash)
		superrem(msg)
		if redis:hget('expiretime', get_receiver(msg)) then redis:hdel('expiretime', get_receiver(msg)) end
		
	end
	-------------------------------------------------------------------------------------------
	
	if not is_super_group(msg) then
		txt = "این گروه جزو گروه های مدیریت شده ی ربات نیست !\nجهت تهیه ی ربات از طریق ربات زیر با ما در ارتباط باشید.\n@EnigmaSupBot"
		return
	end
	
	-- دریافت ادمین های گروه
	if (matches[1] == "ادمین ها" or matches[1]:lower() == "admins") and is_momod(msg) then
		member_type = 'Admins'
		return channel_get_admins(rec,group_admin_list, {receiver = rec, msg = msg, member_type = member_type})
	end
	
	-- دریافت اطلاعات کلی گروه
	if (matches[1] == "اطلاعات گروه" or matches[1]:lower() == "gpinfo") and is_momod(msg) then
		return channel_info(rec, callback_info, {receiver = rec, msg = msg})
	end
	
	-- دریافت مدیران فرعی
	if (matches[1] == "مدیران فرعی" or matches[1]:lower() == "modlist") then
		return modlist(msg)
	end
	
	-- دریافت لیست ربات های معمولی موجود در گروه
	if (matches[1] == "ربات ها" or matches[1]:lower() == "bots") then
		member_type = 'Bots'
		return channel_get_bots(rec, get_bots_list, {receiver = rec, msg = msg, member_type = member_type})
	end
	
	-- دریافت مدیر اصلی بات در گروه
	if (matches[1] == "مدیر اصلی" or matches[1]:lower() == "owner") then
		local group_owner = data[tostring(msg.to.id)]['set_owner']
		if not group_owner then
			txt = "مدیر اصلی ربات در این گروه تنظیم نشده است!"
			return reply_msg(msg.id,txt,ok_cb,false)
		end
		
		txt = "آیدی مدیر اصلی ربات در گروه : "..group_owner
		return reply_msg(msg.id,txt,ok_cb,false)
	end
	-----------------------------------------
	
	-- تنظیم لینک
	if (matches[1] == 'تنظیم لینک' or matches[1]:lower() == "setlink") and is_owner(msg) then
		data[tostring(msg.to.id)]['settings']['set_link'] = 'waiting'
		save_data(_config.moderation.data, data)
		return reply_msg(msg.id,'لطفا لینک جدید را به تنهایی جهت ذخیره ارسال نمایید.',ok_cb,false)
	end
	
	if msg.text then
		if msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") and data[tostring(msg.to.id)]['settings']['set_link'] == 'waiting' and is_owner(msg) then
			data[tostring(msg.to.id)]['settings']['set_link'] = msg.text
			save_data(_config.moderation.data, data)
			return reply_msg(msg.id,"لینک جدید تنظیم شد !\nبرای دریافت لینک میتوانید از این دستور استفاده نمایید :\n👈 لینک",ok_cb,false)
		end
	end
	
	-- دریافت لینک
	if (matches[1] == 'لینک' or matches[1]:lower() == "link") then
		local group_link = data[tostring(msg.to.id)]['settings']['set_link']
		if not group_link then
			return reply_msg(msg.id,"لینکی تنظیم نشده است !\n________\nبرای تنظیم لینک از دستور زیر استفاده کنید :\n👈 تنظیم لینک",ok_cb,false)
		end
		
		return reply_msg(msg.id,"📯 نام گروه : "..msg.to.title.."\n📌 لینک تنظیم شده ی گروه :\n["..group_link.."]",ok_cb,false)
	end
	--------------------
	
	
	-- تغییر نام گروه در جیسون همزمان با تغییر آن در خود گروه
	if msg.service and msg.action.type == 'chat_rename' then
		data[tostring(msg.to.id)]['settings']['set_name'] = msg.to.title
		save_data(_config.moderation.data, data)
	end
	-----------------

	if (matches[1] == 'پاکسازی' or matches[1]:lower() == "clean") and is_owner(msg) then
			
			-- حذف بات های موجود در گروه
			if (matches[2] == "ربات ها" or matches[2]:lower() == "bots") then
				return channel_get_bots(rec, callback_clean_bots, {msg = msg})
			end
			
			-- حذف اکانت های حذف شده از گروه
			if (matches[2] == "حذف شده ها" or matches[2]:lower() == "deleted") then
				return channel_get_users(rec, check_member_super_deleted,{receiver = rec, msg = msg})
			end
			
			if (matches[2] == 'لیست مدیران فرعی' or matches[2]:lower() == "modlist") then
				if next(data[tostring(msg.to.id)]['moderators']) == nil then
					return reply_msg(msg.id,'لیست مدیران فرعی این گروه خالی میباشد !',ok_cb,false)
				end
				for k,v in pairs(data[tostring(msg.to.id)]['moderators']) do
					data[tostring(msg.to.id)]['moderators'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				return reply_msg(msg.id,'لیست مدیران فرعی بات حذف گردید',ok_cb,false)
			end
			
			if (matches[2] == "لیست مسدود" or matches[2]:lower() == "banlist") and is_owner(msg) then
				hash = 'enigma:cli:gpban:'..msg.to.id
				redis:del(hash)
				return reply_msg(msg.id,"لیست مسدودی های گروه پاک شد ... !\n________\nدیگر کسی در این گروه مسدود نمیباشد !",ok_cb,false)
			end
			
			if (matches[2]:lower() == "لیست گلوبال بن" or matches[2]:lower() == "gbanlist") and is_sudo(msg) then
				local hash = 'enigma:cli:gbanned'
				redis:del(hash)
				return reply_msg(msg.id,"<i>لیست کاربران مسدود از تمامی گروه های بات حذف شد !\n________\nاکنون هیچ کس GlobalBan نمیباشد !</i>",ok_cb,false)
			end
			
			if (matches[2] == "مدیر اصلی" or matches[2]:lower() == "owner") and msg.to.type == "channel" and is_sudo(msg) then
				data = load_data(_config.moderation.data)
				owner = data[tostring(msg.to.id)]['set_owner']
				if owner then
					if tostring(owner) ~= "0" then
						data[tostring(msg.to.id)]['set_owner'] = "0"
						save_data(_config.moderation.data, data)
						reply_msg(msg.id,"مدیر اصلی بات در این گروه حذف شد !",ok_cb,false)
					else
						reply_msg(msg.id,"مدیر اصلی بات در این گروه بدرستی تنظیم نشده است !",ok_cb,false)
					end
				end
			end
			
			if (matches[2] == 'لیست سکوت' or matches[2]:lower() == "silentlist") then
				chat_id = msg.to.id
				local hash =  'enigma:cli:mute_user:'..chat_id
				redis:del(hash)
				txt = "لیست کاربران ساکت شده ی گروه پاکسازی شد.\nاکنون کسی در گروه دیگر ساکت شده نمیباشد."
				return reply_msg(msg.id,txt,ok_cb,false)
			end
			
			-- clean filtered words list
			if (matches[2] == "لیست فیلتر" or matches[2]:lower() == "filterlist") then
				FilterHash = "enigma:cli:filtered:"..msg.to.id
				redis:del(FilterHash)
				txt = "لیست کلمات فیتر شده خالی شد !\n________\nاکنون هیچ کلمه ی فیلتر شده ای وجود ندارد !"
				return reply_msg(msg.id,txt,ok_cb,false)
			end
			
		end -- end matches[1] == "پاکسازی"
	
	
		------------ تنظیمات و کار با فیلتر کللمات ----------------
		
		FilterHash = "enigma:cli:filtered:"..msg.to.id
		if (matches[1] == "فیلتر" or matches[1]:lower() == "filter") and matches[2] and is_momod(msg) then
			badword = matches[2]
			is_filtered = redis:sismember(FilterHash,badword)
			if is_filtered == false then
				redis:sadd(FilterHash,badword)
				return reply_msg(msg.id,"عبارت '"..badword.."' به لیست فیلتر شده ها اضافه شد !",ok_cb,false)
			else
				return reply_msg(msg.id,"عبارت '"..badword.."' از قبل فیلتر شده بود !",ok_cb,false)
			end
		end
		
		if (matches[1] == "رفع فیلتر" or matches[1]:lower() == "rf") and matches[2] and is_momod(msg) then
			badword = matches[2]
			is_filtered = redis:sismember(FilterHash,badword)
			if is_filtered == true then
				redis:srem(FilterHash,badword)
				return reply_msg(msg.id,"عبارت '"..badword.."' از لیست فیلتر شده ها حذف گردید !",ok_cb,false)
			else
				return reply_msg(msg.id,"عبارت '"..badword.."' تا به حال فیلتر نشده است که بخواهد حذف گردد !",ok_cb,false)
			end
		end
		
		if (matches[1] == "لیست فیلتر" or matches[1]:lower() == "filterlist") and is_momod(msg) then
			bad = redis:smembers(FilterHash)
			text = '📝 نام گروه : '..msg.to.title..'\n📛 لیست کلمات فیلتر شده :\n________\n'
			for i=1,#bad do
				text = text..i..' - '..bad[i]..'\n'
			end
			return reply_msg(msg.id,text,ok_cb,false)
		end
		
		----------------------------------------------------------
		
		
		------------ تنظیمات مـــــــــــــــــدیریـــــــــــــــــــــــت گـــــــــــــــــــــــــروه ------------
		
		
		-- setowner
		if (matches[1] == "تنظیم مدیر اصلی" or matches[1]:lower() == "setowner") and is_sudo(msg) then
			
			if msg.reply_id then
				local res = {
					cmd = "setowner_reply",
					msg = msg
				}
				
					return get_message(msg.reply_id, set, res)
			
			elseif matches[2] then
				m = matches[2]
				if m:match("@[%a%d]") then
					local username = string.gsub(matches[2],"@","")
					local res = {
						cmd = "setowner_username",
						msg = msg
					}
						return resolve_username(username , set , res)
	
				elseif m:match("^%d+$") then
					
					user_id = tonumber(matches[2])
					chat_id = msg.to.id
					data[tostring(chat_id)]['set_owner'] = tostring(user_id)
					save_data(_config.moderation.data, data)
					
					txt = "کاربر مورد نظر به عنوان مدیر اصلی ربات در گروه تنظیم شد.\n________\nآیدی : "..user_id
					
						return reply_msg(msg.id,txt,ok_cb,false)
						
				end
			
			end
			
			
		end
		
		
		-- promote
		if (matches[1] == "ترفیع" or matches[1]:lower() == "promote") and is_owner(msg) then
			
			if msg.reply_id then
				local res = {
					cmd = "promote_reply",
					msg = msg
				}
				
					return get_message(msg.reply_id, set, res)
			
			elseif matches[2] then
				m = matches[2]
				if m:match("@[%a%d]") then
					local username = string.gsub(matches[2],"@","")
					local res = {
						cmd = "promote_username",
						msg = msg
					}
						return resolve_username(username , set , res)
	
				elseif m:match("^%d+$") then
					
					user_id = tostring(matches[2])
					user_username = "@None"
					chat_id = msg.to.id
					our_id = tonumber(our_id)
					
					if our_id == tonumber(matches[2]) then
						txt = "خود ربات را نمیتوان ترفیع داد."
						return reply_msg(msg.id,txt,ok_cb,false)
					end
					
					if is_owner2(tonumber(matches[2])) then
						txt = "کاربر با آیدی "..user_id.."\nدرحال حاضر مقامی بیشتر از مدیرفرعی در گروه دارد و نیازی به ارتقا نیست."
						return reply_msg(msg.id,txt,ok_cb,false)
					end
					
					if data[tostring(chat_id)]['moderators'][tostring(user_id)] then
						txt = "کاربر با آیدی "..user_id..'\nدر حال حاضر مدیر فرعی ربات در گروه میباشد.'
						return reply_msg(msg.id,txt,ok_cb,false)
					end
						
					data[tostring(chat_id)]['moderators'][tostring(user_id)] = user_username
					save_data(_config.moderation.data, data)
					
					txt = "کاربر مورد نظر به مدیر فرعی ارتقا یافت.\n________\nآیدی : "..user_id
					
						return reply_msg(msg.id,txt,ok_cb,false)
						
				end
			
			end
		
		end -- end promote
		
		
		-- demote
		if (matches[1] == "عزل" or matches[1]:lower() == "demote") and is_owner(msg) then
			
			if msg.reply_id then
				local res = {
					cmd = "demote_reply",
					msg = msg
				}
				
					return get_message(msg.reply_id, set, res)
			
			elseif matches[2] then
				m = matches[2]
				if m:match("@[%a%d]") then
					local username = string.gsub(matches[2],"@","")
					local res = {
						cmd = "demote_username",
						msg = msg
					}
						return resolve_username(username , set , res)
	
				elseif m:match("^%d+$") then
					
					user_id = matches[2]
					user_username = "@None"
					chat_id = msg.to.id
					our_id = tonumber(our_id)
					
					return demote(chat_id,user_id,user_id)
						
				end
			
			end
		
		end -- end demote
		------------------------------------------------
		
		-- delete an msg by reply
		if ( matches[1] == "حذف" or matches[1]:lower() == "del") and is_momod(msg) then
			delete_msg(msg.reply_id,ok_cb,false)
			delete_msg(msg.id,ok_cb,false)
			return
		end
		
		-- me :|
		if (matches[1]:lower() == "me") then
			
			txt = "نمیدونم کی هستی :|"
			
			if is_sudo(msg) then
				txt = "مقام شما : مدیرکل ربات\nستاره : ⭐️⭐️⭐️"
			
			elseif is_owner(msg) then
				txt = "مقام شما : مدیر اصلی ربات در گروه\nستاره : ⭐️⭐️"
			
			elseif is_momod(msg) then
				txt = "مقام شما : مدیر فرعی ربات در گروه\nستاره : ⭐️"
			
			else
				txt = "مقام شما : کاربر عادی در گروه"
			end
			
				return reply_msg(msg.id,txt,ok_cb,false)
		end
				
		
end -- end msg.to.type


end -- end function


return {
patterns = {

	-- نصب و لغو نصب گروه
	"^(نصب)$",
	"^[/!#]([Aa][Dd][Dd])$",
	
	"^(لغو نصب)$",
	"^[/!#]([Rr][Ee][Mm])$",
	
	-- دریافت اطلاعات درباره ی گروه
	"^(ادمین ها)$",
	"^[/!#]([Aa][Dd][Mm][Ii][Nn][Ss])$",
	
	"^(اطلاعات گروه)$",
	"^[/!#]([Gg][Pp][Ii][Nn][Ff][Oo])$",
	
	"^(مدیران فرعی)$",
	"^[/!#]([Mm][Oo][Dd][Ll][Ii][Ss][Tt])$",
	
	"^(ربات ها)$",
	"^[/!#]([Bb][Oo][Tt][Ss])$",
	
	"^(مدیر اصلی)$",
	"^[/!#]([Oo][Ww][Nn][Ee][Rr])$",
	
	-- فیلتر کلمات
	"^(فیلتر) (.*)$",
	"^[/!#]([Ff][Ii][Ll][Tt][Ee][Rr]) (.*)$",
	
	"^(رفع فیلتر) (.*)",
	"^[/!#]([Rr][Ff]) (.*)$",
	
	"^(لیست فیلتر)$",
	"^[/!#]([Ff][Ii][Ll][Tt][Ee][Rr][Ll][Ii][Ss][Tt])$",
	
	-- حذف یک پیام
	"^(حذف)$",
	"^[/!#]([Dd][Ee][Ll])$",
	
	-- تنظیمات لینک گروه
	"^(تنظیم لینک)$",
	"^[/!#]([Ss][Ee][Tt][Ll][Ii][Nn][Kk])$",
	
	"^(لینک)$",
	"^[/!#]([Ll][Ii][Nn][Kk])$",
	
	-- تنظیمات و کار با مدیریت
	"^(تنظیم مدیر اصلی)$",
	"^[/!#]([Ss][Ee][Tt][Oo][Ww][Nn][Ee][Rr])$",
	
	"^(ترفیع)$",
	"^[/!#]([Pp][Rr][Oo][Mm][Oo][Tt][Ee])$",
	
	"^(عزل)$",
	"^[/!#]([Dd][Ee][Mm][Oo][Tt][Ee])$",
	
	"^(تنظیم مدیر اصلی) (.*)$",
	"^[/!#]([Ss][Ee][Tt][Oo][Ww][Nn][Ee][Rr]) (.*)$",
	
	"^(ترفیع) (.*)$",
	"^[/!#]([Pp][Rr][Oo][Mm][Oo][Tt][Ee]) (.*)$",
	
	"^(عزل) (.*)$",
	"^[/!#]([Dd][Ee][Mm][Oo][Tt][Ee]) (.*)$",
	
	-- پاکسازی
	"^(پاکسازی) (.*)$",
	"^[/!#]([Cc][Ll][Ee][Aa][Nn]) (.*)$",
	
	-- تقریبا فان :|
	"^[/!#]([Mm][Ee])$",
	
	--------------------
	"^([https?://w]*.?telegram.me/joinchat/%S+)$",
	"%[(document)%]",
	"%[(photo)%]",
	"%[(video)%]",
	"%[(audio)%]",
	"%[(contact)%]",
	"^!!tgservice (chat_rename)$"
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