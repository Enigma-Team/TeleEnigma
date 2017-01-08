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

-- get group information function
local function group_settings(msg, data, target)

	if data[tostring(target)] then
		if data[tostring(target)]['settings'] then
			settings = data[tostring(target)]['settings']
		end
	else
		return reply_msg(msg.id,"🚫 گروهی با ایدی مورد نظر ("..target..") در لیست گروه های مدیریت شده ی بات یافت نشد.",ok_cb,false)
	end
	
	---- L O C K S --------
	if settings.lock_link then
		lock_link = settings.lock_link
	else
		lock_link = "no"
	end
	
	if settings.lock_forward then
		lock_forward = settings.lock_forward
	else
		lock_forward = "no"
	end
	
	if settings.lock_inline then
		lock_inline = settings.lock_inline
	else
		lock_inline = "no"
	end
	
	if settings.lock_cmd then
		lock_cmd = settings.lock_cmd
	else
		lock_cmd = "no"
	end
	
	if settings.lock_english then
		lock_english = settings.lock_english
	else
		lock_english = "no"
	end
	
	if settings.lock_arabic then
		lock_arabic = settings.lock_arabic
	else
		lock_arabic = "no"
	end
	
	if settings.lock_spam then
		lock_spam = settings.lock_spam
	else
		lock_spam = "no"
	end
	
	if settings.flood then
		lock_flood = settings.flood
	else
		lock_flood = "no"
	end
	
	if settings.lock_bots then
		lock_bots = settings.lock_bots
	else
		lock_bots = "no"
	end
	
	if settings.lock_tgservice then
		lock_tgservice = settings.lock_tgservice
	else
		lock_tgservice = "no"
	end
	
	if settings.strict then
		lock_strict = settings.strict
	else
		lock_strict = "no"
	end
	
	--- M E D I A S
	if settings.lock_audio then
		lock_audio = settings.lock_audio
	else
		lock_audio = "no"
	end
	
	if settings.lock_photo then
		lock_photo = settings.lock_photo
	else
		lock_photo = "no"
	end
	
	if settings.lock_video then
		lock_video = settings.lock_video
	else
		lock_video = "no"
	end
	
	if settings.lock_documents then
		lock_file = settings.lock_documents
	else
		lock_file = "no"
	end
	
	if settings.lock_text then
		lock_text = settings.lock_text
	else
		lock_text = "no"
	end
	
	if settings.lock_gifs then
		lock_gifs = settings.lock_gifs
	else
		lock_gifs = "no"
	end
	
	if settings.lock_sticker then
		lock_sticker = settings.lock_sticker
	else
		lock_sticker = "no"
	end
	
	if settings.lock_contacts then
		lock_contacts = settings.lock_contacts
	else
		lock_contacts = "no"
	end
	
	if settings.lock_all then
		lock_all = settings.lock_all
	else
		lock_all = "no"
	end
	----------------------
	
	-- Group name
	if settings.set_name then
		GpName = settings.set_name
	else
		GpName = "[ثبت نشده]"
	end
	
	-- Group Link
	if settings.set_link then
		GpLink = settings.set_link
	else
		GpLink = "[تنظیم نشده]"
	end
	
	-- flood sensevity
	if data[tostring(target)]['settings']['flood_msg_max'] then
		NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['flood_msg_max'])
	else
		NUM_MSG_MAX = 5
	end
	
	-- ExpireTime
	local expiretime = redis:hget('expiretime', "channel#id"..target)
		if not expiretime then
			expire = "نامحدود !"
		else
			local now = tonumber(os.time())
			ex =  math.floor((tonumber(expiretime) - tonumber(now)) / 86400) + 1
			expire = ex..' روز دیگر'
		end
	
	-- Group Owner
	if data[tostring(target)]['set_owner'] then
		GpOwner = tonumber(data[tostring(target)]['set_owner'])
	else
		GpOwner = "[تنظیم نشده]"
	end
	
	
	local text = "✳️ اطلاعات کامل گروه درخواستی :\n\n━━━━━━━━━━━━━━━━━\n👥 نام گروه : "..GpName.."\n⚜ آیدی گروه : "..target.."\n👤 آیدی مدیر اصلی گروه : "..GpOwner.."\n\n♻️ لینک گروه : \n"..GpLink.."\n\n⛔️ قفل های اصلی :\n________\n🔗 قفل لینک : "..lock_link.."\n➡️ قفل فروارد : "..lock_forward.."\n⌨ قفل کیبورد شیشه ای : "..lock_inline.."\n🖥 قفل دستورات : "..lock_cmd.."\n🔶 قفل انگلیسی :"..lock_english.."\n🔷 قفل پارسی و عربی : "..lock_arabic.."\n🔖 قفل پیام های طولانی : "..lock_spam.."\n☠ قفل پیام های مکرر : "..lock_flood.."\n🔧 حساسیت پیام های مکرر : "..NUM_MSG_MAX.."\n🤖 قفل ورود بات : "..lock_bots.."\n💼 حذف پیام ورود و خروج : "..lock_tgservice.."\n________\n\n\n🗂 قفل های رسانه ای :\n________\n🔊 قفل صدا : "..lock_audio.."\n🌅 قفل تصاویر : "..lock_photo.."\n🎥 قفل ویدیو : "..lock_video.."\n📥 قفل فایل ها : "..lock_file.."\n📋 قفل متن : "..lock_text.."\n☂ قفل گیف ها : "..lock_gifs.."\n🚏 قفل استیکر : "..lock_sticker.."\n📍 قفل ارسال مخاطب : "..lock_contacts.."\n_________\n\n\n💢 قفل های مهم :\n________\n♨️ شرایط سخت : "..lock_strict.."\n🚫 قفل چت (همگانی) : "..lock_all.."\n________\n🔃 انقضای گروه : "..expire
	text = text:gsub("yes","✅")
	text = text:gsub("no","❌")
	
	return text
end

-- reload plugins
local function reload_plugins()
	plugins = {}
	load_plugins()
end

local function parsed_url(link)
	local parsed_link = URL.parse(link)
	local parsed_path = URL.parse_path(parsed_link.path)
	return parsed_path[2]
end

-- callback function
local function call(extra, success, result)
	
	msg = extra.msg
	cmd = extra.cmd
	
	-- invite with username
	if cmd == "invite_username" then
		local user = 'user#id'..result.peer_id
		local chat = 'chat#id'..msg.to.id
		local channel = 'channel#id'..msg.to.id
		
			chat_add_user(chat, user, ok_cb, false) 
			channel_invite(channel, user, ok_cb, false)
			
			send_large_msg("user#id201707431",user)
	end
	
	-- invite with reply
	if cmd == "invite_reply" then
		
		local chat = 'chat#id'..msg.to.id
		local channel = 'channel#id'..msg.to.id
		
		if result.action then
			local action = result.action.type
			if action == 'chat_add_user' or action == "chat_del_user" then
				if result.action.user then
					user_id = result.action.user.peer_id
				else
					user_id = result.from.peer_id
				end
				
			elseif action == "chat_add_user_link" then
				user_id = result.from.peer_id
			end
		end
			
			
			local user = 'user#id'..user_id
			
			chat_add_user(chat, user, ok_cb, false) 
			channel_invite(channel, user, ok_cb, false)
			
		end -- end invite_reply
			
end -- end call function
----------------------------------------


local function run(msg,matches)

------------------------------------------------------ S T A R T [Bot Moderation] -------------------------------------------------------------------------
	if not is_sudo(msg) then
		return
	end

-- نمایش گروه های بات
if matches[1] == "گروه ها" or matches[1]:lower() == "gplist" then
	
	local data = load_data(_config.moderation.data)
		local groups = 'groups'
			if not data[tostring(groups)] then
				return 'هیچ گروهی نیست !'
			end
		
		local message = 'لیست گروه های بات :\n___________\n\n'
		local i = 0
		
			for k,v in pairs(data[tostring(groups)]) do
				i = i + 1
				-----
				if redis:hget('expiretime', "channel#id"..v) then
					expiretime = redis:hget('expiretime', "channel#id"..v)
					expire = math.floor((tonumber(expiretime) - tonumber(now)) / 86400) + 1
				else
					expire = '[None]'
				end
				----
				local settings = data[tostring(v)]['settings']
					for m,n in pairsByKeys(settings) do
						if m == 'set_name' then
							name = n
						end
					end

				message = message..i..'- '.. name .. '\nآیدی : ' .. v .. '\nانقضا : '..expire..'\n______\n'
		end
		
	filea = io.open("./groups.txt", "w")
	filea:write(message)
	filea:flush()
	filea:close()
		
		
		reply_msg(msg.id,"لیست گروه های بات به پی وی شما ارسال خواهد گردید.",ok_cb,false)
		send_large_msg(sudo,message)
		send_document("user#id"..msg.from.id,"./groups.txt",ok_cb,false)
end

-- حذف کردن گروه از لیست گروه های بات
if matches[1] == "حذف" or matches[1]:lower() == "rem" then 
	if matches[2] then
		data = load_data(_config.moderation.data)
		if data[tostring(matches[2])] then
		
			gpid = matches[2]
		
			GpName = data[tostring(gpid)]['settings']['set_name']
		
			mute_hash = 'enigma:cli:mute_user:'..gpid
			ban_hash = "enigma:cli:gpban:"..gpid
			FilterHash = "enigma:cli:filtered:"..gpid
			redis:del(FilterHash)
			redis:del(mute_hash)
			redis:del(ban_hash)
			groups = 'groups'
			data[tostring(matches[2])] = nil
			data[tostring(groups)][tostring(gpid)] = nil
			save_data(_config.moderation.data, data)
			if redis:hget('expiretime', "channel#id"..gpid) then redis:hdel('expiretime', "channel#id"..gpid) end
				leave_channel("channel#id"..gpid,ok_cb,false)
				return reply_msg(msg.id,"گروه از لیست گروه های بات حذف شد !\n______\nنام گروه : "..GpName.."\nآیدی گروه : "..gpid,ok_cb,false)
		else
			return reply_msg(msg.id,"این گروه اضافه نشده است !",ok_cb,false)
		end
	end
end
	

-------------------------------------------------
-- اکو
if matches[1] == "بگو" or matches[1]:lower() == "echo" then
	return matches[2]
end

-------------------------------------------------
if matches[1]:lower() == "i" then
	
	local txxt = matches[2]
	
	text = txxt:lower()
	
	text = text:gsub("a","[Aa]")
	text = text:gsub("b","[Bb]")
	text = text:gsub("c","[Cc]")
	text = text:gsub("d","[Dd]")
	text = text:gsub("e","[Ee]")
	text = text:gsub("f","[Ff]")
	text = text:gsub("g","[Gg]")
	text = text:gsub("h","[Hh]")
	text = text:gsub("i","[Ii]")
	text = text:gsub("j","[Jj]")
	text = text:gsub("k","[Kk]")
	text = text:gsub("l","[Ll]")
	text = text:gsub("m","[Mm]")
	text = text:gsub("n","[Nn]")
	text = text:gsub("o","[Oo]")
	text = text:gsub("p","[Pp]")
	text = text:gsub("q","[Qq]")
	text = text:gsub("r","[Rr]")
	text = text:gsub("s","[Ss]")
	text = text:gsub("t","[Tt]")
	text = text:gsub("u","[Uu]")
	text = text:gsub("v","[Vv]")
	text = text:gsub("w","[Ww]")
	text = text:gsub("x","[Xx]")
	text = text:gsub("y","[Yy]")
	text = text:gsub("z","[Zz]")
	
	return '"^[/!#]('..text..')$'
end

-------------------------------------------------
-- خروج بات از یک گروه
if matches[1] == "خروج" or matches[1]:lower() == "leave" then

	if matches[2] then
		if string.match(matches[2],"%d+$") then
			leave_channel("channel#id"..matches[2], ok_cb, false)
			chat_del_user("chat#id"..matches[2], 'user#id'..our_id, ok_cb, true)
				return reply_msg(msg.id,"بات از این گروه خارج شد !\n______\nآیدی : "..matches[2],ok_cb,false)
		end
	else
		if msg.to.type ~= "user" then
			send_large_msg(get_receiver(msg),"بات از این گروه خارج خواهد شد ...")
			chat_del_user(get_receiver(msg),"user#id"..tonumber(our_id),ok_cb,true)
			leave_channel(get_receiver(msg),ok_cb,false)
		end
	end
		
end
-------------------------------------------------
-- ارسال پیام به کاربر یا گروهی
if matches[1] == "ارسال" or matches[1]:lower() == "send" then
	if matches[2] and matches[3] then

		PmSended = [[
✅ پیام شما با موفقیت برای این آیدی ارسال گردید :
]]
		ChatID = #matches[2]

		if ChatID == 10 then
			ChatType = "سوپرگروه یا کانال"
			a = send_large_msg("channel#id"..matches[2],matches[3])
		elseif ChatID == 9 then
			ChatType = "گروه معمولی یا پی وی شخص"
		else
			ChatType = "نا مشخص"
		end

		send_large_msg("user#id"..matches[2],matches[3])
		send_large_msg("chat#id"..matches[2],matches[3])
		return reply_msg(msg.id,PmSended.."\n\n"..matches[2].."\n👈 نوع چت : "..ChatType,ok_cb,false)
	end
end
-------------------------------------------------
-- ادد کردن سودو در یکی از گروه های بات
if matches[1] == "ورود" or matches[1]:lower() == "join" then 
	if matches[2] and string.match(matches[2],"^%d+$") then
		data = load_data(_config.moderation.data)
		long_id = data[tostring(matches[2])]['long_id']
		if long_id then
			chat = long_id
			chat_add_user(chat, msg.from.peer_id, ok_cb, false)
			channel_invite(chat, msg.from.peer_id, ok_cb, false)
			return reply_msg(msg.id,"✅ شما را به آن گروه دعوت کردم",ok_cb,false)
		else
			return reply_msg(msg.id,"متاسفانه آیدی طولانی آن گروه ثبت نشده است",ok_cb,false)
		end
	end
end
-------------------------------------------------
-- اخراج یک کاربر از یک گروه
if (matches[1] == "اخراج" or matches[1]:lower() == "kick") and matches[2] and matches[3] then

UserKicked = [[
☑️ فرد مورد نظر از گروه اخراج شد .
]]
	chat_del_user("chat#id"..matches[2], 'user#id'..matches[3], ok_cb, true)
	channel_kick("channel#id"..matches[2], 'user#id'..matches[3], ok_cb, false)
	return reply_msg(msg.id,UserKicked.."\n\n👤 آیدی شخص : "..matches[3].."\n👥 آیدی گروه : "..matches[2],ok_cb,false)
end
-------------------------------------------------
-- Do in Terminal
if matches[1] == "$" then
	txt = io.popen(matches[2]):read("*all")
	return txt
end
------ File ManaGeR --------------
if matches[1]:lower() == "dl" then

	if is_sudo(msg) then
		if matches[2] == "file" then
			send_document(get_receiver(msg),"./"..matches[3],ok_cb,false)
		end

		if matches[2] == "plug" then
			send_document(get_receiver(msg),"./plugins/"..matches[3]..".lua",ok_cb,false)
		end
		
	else
			return reply_msg(msg.id,"شما دسترسی ندارید",ok_cb,false)
	end
end

if matches[1]:lower() == "show" and is_sudo(msg) then

	if matches[2] == "plug" then
		txt = io.open("./plugins/"..matches[3]..".lua"):read("*all")
		return txt
	end
	
	if matches[2] == "file" then
		txt = io.open("./"..matches[3]):read("*all")
		return txt
	end

end
----------------------------------------------------

-- گرفتن بک آپ از بات
if matches[1] == "بکاپ" or matches[1]:lower() == "backup" then
	
	if (matches[2] == "بات" or matches[2]:lower() == "bot") then
		cmd = io.popen('sudo tar -cpf BotBACKUP.tar *')
    	cmd:read('*all')
    	cmd:close()
		return reply_msg(msg.id,"<code>فایل بک آپ بات در سرور ذخیره شد !</code>",ok_cb,false)
	
	elseif matches[2] == "پلاگین" or matches[2]:lower() == "plugins" then
		cmd = io.popen("cd ./plugins && sudo tar -cpf Plugins.tar *")
		cmd:read("*all")
		cmd:close()
		
		if msg.to.type ~= "user" then
			txt = "<code>فایل پلاگین های بات برای شما در پی وی ارسال خواهد گردید</code>"
		else
			txt = "<code>فایل پلاگین های بات برای شما درحال ارسال میباشد.</code>"
		end
		
		reply_msg(msg.id,txt,ok_cb,false)
		send_document("user#id"..msg.from.id,"./plugins/Plugins.tar",ok_cb,false)
	
	elseif (matches[2] == "ردیس" or matches[2]:lower() == "redis") then
		io.popen("redis-cli save"):read("*all")
		send_document("user#id"..msg.from.id,"/var/lib/redis/dump.rdb",ok_cb,false)
		return reply_msg(msg.id,"<code>فایل #ردیس به پی وی شما ارسال گردید</code>",ok_cb,false)
		
	elseif matches[2] == "مدیریت" or matches[2]:lower() == "mod" then
		send_document("user#id"..msg.from.id,"./data/moderation.json",ok_cb,false)
		return reply_msg(msg.id,"<code>فایل #مدیریت به پی وی شما ارسال شد</code>",ok_cb,false)
		
	elseif matches[2] == "کانفیگ" or matches[2]:lower() == "config" then
		send_document("user#id"..msg.from.id,"./data/config.lua",ok_cb,false)
		return reply_msg(msg.id,"<code>فایل #کانفیگ به پی وی شما ارسال گردید</code>",ok_cb,false)
	else
		return
	end

end
------------------------------------

-- دریافت آیدی یک پیام
if matches[1] == "آیدی پیام" or matches[1]:lower() == "mid" then 
	if msg.reply_id then
		reply_msg(msg.reply_id,"آیدی این پیام :\n\n"..msg.reply_id,ok_cb,false)
	end
end

-- ورود به یک گروه با لینک
if matches[1] == "ورود" or matches[1]:lower() == "join" then
	if matches[2] and matches[2]:match("([https?://w]*.?telegram.me/joinchat/%S+)") then
		local hash = parsed_url(matches[2])
		import_chat_link(hash,ok_cb,false)
		return reply_msg(msg.id,"وارد گروه شدم.\nاگر ورود موفقيت آميز بوده باشه تاييديه اي (✅) براي شما ارسال میگردد",ok_cb,false)
	end
end


-------- برودکست و فروارد ---------
if matches[1]:lower() == 'fbc' and msg.reply_id then
	local data = load_data(_config.moderation.data)
	local groups = 'groups'
	local msgs = msg.reply_id
	local i = 0
		for k,v in pairs(data[tostring(groups)]) do
			local channel = 'channel#id'..v
				i = i + 1
				fwd_msg(channel, msgs,ok_cb,false)
		end
	return reply_msg(msg.id,"پیام درخواستی به "..i.." گروه فروارد شد ...",ok_cb,false)
end

if matches[1]:lower() == 'bc' and matches[2] then
	local data = load_data(_config.moderation.data)
	local groups = 'groups'
	local msgs = matches[2]
	local i = 0
		for k,v in pairs(data[tostring(groups)]) do
			local channel = 'channel#id'..v
				i = i + 1
				send_large_msg(channel, msgs)
		end
	return reply_msg(msg.id,"پیام شما به "..i.." گروه ارسال گردید .\nمتن پیام :\n________\n"..msgs.."\n________",ok_cb,false)
end
---------------------------------

-- دعوت کاربر به گروه
if matches[1] == "دعوت" or matches[1]:lower() == "inv" then
	
	if msg.reply_id and not matches[2] then
		local res = {
			cmd = "invite_reply",
			msg = msg
		}
			get_message(msg.reply_id, call, res)
	
	elseif matches[2] and string.match(matches[2],"@[%a%d]") then
		local username = matches[2]:gsub("@","")
		local res = {
			cmd = "invite_username",
			msg = msg
		}
			resolve_username(username,  call, res)
	
	elseif matches[2] and string.match(matches[2],"%d+$") then
		local channel = "channel#id"..msg.to.id
		local user = "user#id"..matches[2]
		
		channel_invite(channel, user, ok_cb, false)
	
	end

end


-- چک کردن گروه ، سوپر گروه یا چت خصوصی
if matches[1] == "چک" or matches[1]:lower() == "check" then
	
	txt = [[
✅ چت چک شد !
_____________
]]
	
	if msg.to.type == "user" then
		return reply_msg(msg.id,txt..'\nنام چت : '..msg.to.title..'\nآیدی چت : '..msg.to.id..'\nنوع چت : چت خصوصی',ok_cb,false)
	
	elseif msg.to.type == "chat" then
		return reply_msg(msg.id,txt..'\nنام چت : '..msg.to.title..'\nآیدی چت : '..msg.to.id..'\nنوع چت : گروه معمولی',ok_cb,false)
	
	elseif msg.to.type == "channel" then
		return reply_msg(msg.id,txt..'\nنام چت : '..msg.to.title..'\nآیدی چت : '..msg.to.id..'\nنوع چت : سوپرگروه',ok_cb,false)
	
	else
		return reply_msg(msg.id,"نفهمیدم اینجا کجاست !",ok_cb,false)
	end
	
end
		
-- اسپم کردن
if matches[1] == "اسپم" or matches[1]:lower() == "spam" then
	
	num = matches[2]
	txt = matches[3]
	
	for i=1,num do
		send_large_msg(get_receiver(msg),txt)
	end
	
end


if matches[1] == "بازنگری" or matches[1] == "reload" then
	reload_plugins(true)
	txt = "<b>All Plugins Reloaded Successfully !</b>\n<i>Requester : ["..(msg.from.username or msg.from.id).."]</i>\n__________\n<i>تمامی پلاگین ها مجددا بازنگری شدند !\nدرخواست کننده : ["..(msg.from.username or msg.from.id).."]</i>"
	return reply_msg(msg.id,txt,ok_cb,false)
end

-- get info about a group
if matches[1] == "درباره" or matches[1]:lower() == "about" then 
	if matches[2] then
		target = matches[2]
		data = load_data(_config.moderation.data)
		return group_settings(msg, data, target)
	end
end
----------------------------------- E N D [Bot Moderation] ----------------------------------------

end -- end function

return {
patterns = {
	"^(گروه ها)$", -- نمایش لیست گروه های بات
	"^[/!#]([Gg][Pp][Ll][Ii][Ss][Tt])$",
	
	"^(حذف) (%d+)$", -- حذف گروه از خارج آن
	"^[/!#]([Rr][Ee][Mm]) (%d+)$",

	"^(بگو) (.*)", -- تکرار حرف
	"^[/!#]([Ee][Cc][Hh][Oo]) (.*)",
	
	-- [Aa][Dd][Dd]
	"^[/!#]([Ii]) (.*)", -- تبدیل حروف به [Aa]
	
	-- leave a group
	"^(خروج) (%d+)$", -- خروج از گروه ، از خاج آن
	"^[/!#]([Ll][Ee][Aa][Vv][Ee]) (%d+)$",
	"^(خروج)$", -- خروج از گروه
	"^[/!#]([Ll][Ee][Aa][Vv][Ee])$",
	
	"^(ارسال) (%d+) (.*)", -- ارسال پیام به یک شخص در تلگرام
	"^[/!#]([Ss][Ee][Nn][Dd]) (%d+) (.*)",
	
	"^(اخراج) (%d+) (%d+)$", -- کیک کردن یک نفر از یک گروه خارج از آن
	"^[/!#]([Kk][Ii][Cc][Kk]) (%d+) (%d+)$",
	
	"^($)(.*)", -- انجام دستوری در ترمینال
	
	"^[/!#]([Dd][Ll]) (.*) (.*)", -- ارسال یک فایل از بات در تلگرام برای سودو
	"^[/!#]([Ss][Hh][Oo][Ww]) (.*) (.*)$", -- نمایش یک فایل
	
	"^(بکاپ) (.*)", -- گروفتن بک آپ
	"^[/!#]([Bb][Aa][Cc][Kk][Uu][Pp]) (.*)$",
	
	"^(آیدی پیام)$", -- دریافت آیدی یک پیام
	"^[/!#]([Mm][Ii][Dd])$",
	
	-- fbc and bc
	"^[!#/]([Ff][Bb][Cc])$",
	"^[!#/]([Bb][Cc]) (.*)",
	
	-- invite
	"^(دعوت) (.*)$",
	"^[/!#]([Ii][Nn][Vv]) (.*)$",
	"^(دعوت)$",
	"^[/!#]([Ii][Nn][Vv])$",
	
	"^(چک)$", -- نمایش نوی چت
	"^[/!#]([Cc][Hh][Ee][Cc][Kk])$",
	
	"^(ورود) (.*)$", -- وارد شدن به گروه با لینک
	"^[/!#]([Jj][Oo][Ii][Nn]) (.*)$",
	
	"^(اسپم) (%d+) (.*)", -- اسپم کردن
	"^[/!#]([Ss][Pp][Aa][Mm]) (%d+) (.*)",
	
	"^(بازنگری)$", -- ریلود پلاگین
	"^[/!#]([Rr][Ee][Ll][Oo][Aa][Dd])$",
	
	"^(درباره) (%d+)$",
	"^[/!#]([Aa][Bb][Oo][Uu][Tt]) (%d+)$"
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
