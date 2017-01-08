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

local function run(msg,matches)
	
	------- LOCK CMD
	data = load_data(_config.moderation.data)
	if data[tostring(msg.to.id)] then
		if data[tostring(msg.to.id)]['settings'] then
			if data[tostring(msg.to.id)]['settings']['lock_wlc'] then
				WLC = data[tostring(msg.to.id)]['settings']['lock_wlc']
			end
		end
	end
	-------
	
	url , res = http.request('http://api.gpmod.ir/time/')
	jdat = json:decode(url)
	if res == 200 then 
		Time = jdat.FAtime
	else
		Time = ''
	end
	
	user_id = msg.from.id
	user_name = msg.from.print_name
	user_name = user_name:gsub("_"," ")
	
	group_name = msg.to.title
	group_id = msg.to.id
	
	text = "سلام "..user_name..'\nبه '..group_name..' خوش اومدی !\n'..Time
	
	if msg.service then
		if WLC then
			if WLC == "yes" then
				return reply_msg(msg.id,text,ok_cb,false)
			end
		end
	end
	
end

return {
patterns = {
	"^!!tgservice (chat_add_user_link)$"
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