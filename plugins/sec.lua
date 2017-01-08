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

local function pre_process(msg)

if is_super_group(msg) then
	local data = load_data(_config.moderation.data)
	local print_name = user_print_name(msg.from):gsub("‮", "") -- get rid of rtl in names
	local name_log = print_name:gsub("_", " ") -- name for log
	if data[tostring(msg.to.id)] and data[tostring(msg.to.id)]['settings'] then
		settings = data[tostring(msg.to.id)]['settings']
	else
		return
	end
	------- L O C K S ----------
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
	
		-------------------------
	
if not is_momod(msg) then

	-- kick banned user
	if is_banned(msg.from.id, msg.to.id) or is_gbanned(msg.from.id) then
		delete_msg(msg.id,ok_cb,false)
		kick_user(msg.from.id,msg.to.id)
	end
	
	-- lock all
	if lock_all == "yes" and not msg.service then
		delete_msg(msg.id,ok_cb,false)
	end
	
	-- del msg of muted user
	if is_muted_user(msg.to.id, msg.from.id) and not msg.service then
		delete_msg(msg.id, ok_cb, false)
	end
	
	-- rem msg with filtered word !
	if msg.text then
		filterHash = "enigma:cli:filtered:"..msg.to.id
		is_bad = redis:smembers(filterHash)
		for i=1,#is_bad do
			if string.match(msg.text,is_bad[i]) then
				delete_msg(msg.id,ok_cb,false)
			end
		end
	end
	
	if msg.media then
		filterHash = "enigma:cli:filtered:"..msg.to.id

		if msg.media.title then
			is_bad = redis:smembers(filterHash)
			for i=1,#is_bad do
				if string.match(msg.media.title,is_bad[i]) then
					delete_msg(msg.id,ok_cb,false)
				end
			end
		end
		
		if msg.media.caption then
			is_bad = redis:smembers(filterHash)
			for i=1,#is_bad do
				if string.match(msg.media.caption,is_bad[i]) then
					delete_msg(msg.id,ok_cb,false)
				end
			end
		end
		
		if msg.media.description then
			is_bad = redis:smembers(filterHash)
			for i=1,#is_bad do
				if string.match(msg.media.description,is_bad[i]) then
					delete_msg(msg.id,ok_cb,false)
				end
			end
		end
		
	end -- end msg.media
		
		-- kick banned
		if msg.action then
		
			action = msg.action.type
			if action == "chat_add_user_link" then
				banned = is_banned(msg.from.id, msg.to.id)
				if banned or is_gbanned(msg.from.id) then
					delete_msg(msg.id,ok_cb,false)
					kick_user(msg.from.id, msg.to.id)
				end
			end
			
			if action == "chat_add_user" then
				uid = msg.action.user.id
				banned = is_banned(uid, msg.to.id)
				if banned or is_gbanned(uid) then
					delete_msg(msg.id,ok_cb,false)
					kick_user(uid, msg.to.id)
				end
			
			-- lock bots
				if msg.action.user.username ~= nil then
					if string.sub(msg.action.user.username:lower(), -3) == 'bot' and lock_bots == "yes" then
						delete_msg(msg.id,ok_cb,false)
						kick_user(msg.action.user.id, msg.to.id)
					end
				end
				
			end
			
		end -- end msg.action
		
		
		if msg.text then -- msg.text checks
			
			-- lock spam
			local _nl, ctrl_chars = string.gsub(msg.text, '%c', '')
			 local _nl, real_digits = string.gsub(msg.text, '%d', '')
			if string.len(msg.text) > 2049 or ctrl_chars > 40 or real_digits > 2000 then
				if lock_spam == "yes" then
					delete_msg(msg.id, ok_cb, false)
				end
			end
			
		if msg.fwd_from then
			
			-- lock forward
			if lock_forward == "yes" then
				delete_msg(msg.id,ok_cb,false)
			
			elseif msg.fwd_from.title then
				-- lock link
				local is_link_title = msg.fwd_from.title:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.fwd_from.title:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.fwd_from.title:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.fwd_from.title:match("[Hh][Tt][Tt][Pp]://")
				if is_link_title and lock_link == "yes" then
					delete_msg(msg.id, ok_cb, false)
					if lock_strict == "yes" then
						kick_user(msg.from.id,msg.to.id)
					end
				end
				
			end -- end msg.fwd_from.title
			
		end -- end msg.fwd_from
			
			-- lock link
			local is_link_msg = msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.text:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.text:match("[Hh][Tt][Tt][Pp]://")
			if is_link_msg and lock_link == "yes" then
				delete_msg(msg.id, ok_cb, false)
				if lock_strict == "yes" then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			
			-- lock english
			local is_english_msg = msg.text:match("[A-Z]") or msg.text:match("[a-z]")
			if is_english_msg and lock_english == "yes" then
				delete_msg(msg.id, ok_cb, false)
			end
			
			-- lock arabic
			local is_squig_msg = msg.text:match("[\216-\219][\128-\191]")
			if is_squig_msg and lock_arabic == "yes" then
				delete_msg(msg.id, ok_cb, false)
			end
			
			-- lock text
			if lock_text == "yes" and not msg.media and not msg.service then
				delete_msg(msg.id, ok_cb, false)
			end
			
			-- lock tgservice
			if msg.service and lock_tgservice == "yes" then
				delete_msg(msg.id, ok_cb, false)
			end
			
		end -- end msg.text
		
		
		if msg.media then -- msg.media checks
			
			if msg.media.title then
				
				-- lock link
				local is_link_title = msg.media.title:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.media.title:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.media.title:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.media.title:match("[Hh][Tt][Tt][Pp]://")
				if is_link_title and lock_link == "yes" then
					delete_msg(msg.id, ok_cb, false)
					if lock_strict == "yes" then
						kick_user(msg.from.id,msg.to.id)
					end
				end
				
			end -- end msg.media.title
			
			if msg.media.description then
			
				-- lock link
				local is_link_desc = msg.media.description:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.media.description:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.media.description:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.media.description:match("[Hh][Tt][Tt][Pp]://")
				if is_link_desc and lock_link == "yes" then
					delete_msg(msg.id, ok_cb, false)
					if lock_strict == "yes" then
						kick_user(msg.from.id, msg.to.id)
					end
				end
				
			end -- end msg.media.description
			
			
			if msg.media.caption then -- msg.media.caption checks
			
				-- lock link
				local is_link_caption = msg.media.caption:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.media.caption:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.media.caption:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.media.caption:match("[Hh][Tt][Tt][Pp]://")
				if is_link_caption and lock_link == "yes" then
					delete_msg(msg.id, ok_cb, false)
					if lock_strict == "yes" then
						kick_user(msg.from.id, msg.to.id)
					end
				end
				
			-- lock sticker
			if lock_sticker == "yes" and msg.media.caption:match("sticker.webp") and not msg.service then
				delete_msg(msg.id, ok_cb, false)
			end
			
		end -- end msg.media.caption
			
			-- lock contact
			if msg.media.type:match("contact") and lock_contacts == "yes" and not msg.service then
				delete_msg(msg.id, ok_cb, false)
			end
			
			-- lock photo
			local is_photo_caption = msg.media.caption and msg.media.caption:match("photo")--".jpg",
			if lock_photo == "yes" and msg.media.type:match("photo") or is_photo_caption and not msg.service then
				delete_msg(msg.id, ok_cb, false)
			end
			
			-- lock gif
			local is_gif_caption =  msg.media.caption and msg.media.caption:match(".mp4")
			if lock_gifs == "yes" and is_gif_caption and msg.media.type:match("document") and not msg.service then
				delete_msg(msg.id, ok_cb, false)
			end
			
			-- lock inline
			if lock_inline == "yes" and msg.media.type:match("unsupported") and not msg.service then
				delete_msg(msg.id,ok_cb,false)
			end
			
			-- lock audio
			if lock_audio == "yes" and msg.media.type:match("audio") and not msg.service then
				delete_msg(msg.id, ok_cb, false)
			end
			
			-- lock video
			local is_video_caption = msg.media.caption and msg.media.caption:lower(".mp4","video")
			if lock_video == "yes" and msg.media.type:match("video") and not msg.service then
				delete_msg(msg.id, ok_cb, false)
			end
			
			-- lock file
			if lock_file == "yes" and msg.media.type:match("document") and not msg.service then
				delete_msg(msg.id, ok_cb, false)
			end
		end
		
	end -- end not is_momod(msg)

end -- end is_super_group(msg)
	return msg
end -- end function pre_process

return {
patterns = {},pre_process = pre_process
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