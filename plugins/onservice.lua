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

SudoID = _config.sudo_users[1]
Sudo = "user#id"..SudoID

function run(msg,matches)

	if msg.service then
		action = msg.action.type
		if action == "chat_add_user" then
			added_id = msg.action.user.id
			if tonumber(added_id) == tonumber(our_id) then
				adder_name = string.gsub(msg.from.print_name,"_"," ")
				adder_id = msg.from.id
				adder_username = (msg.from.username or "----")
				gp_name = msg.to.title
				gp_id = msg.to.id
				if msg.to.type == "channel" then
					gp_type = "سوپرگروه"
				elseif msg.to.type == "chat" then
					gp_type = "گروه عادی"
				else
					gp_type = "None"
				end
				txt = "یکی منو به یه گروهی اضافه کرد!\n__________\nنام : "..adder_name.."\nیوزرنیم : @"..adder_username.."\nآیدی : "..adder_id.."\n\nنام گروه : "..gp_name.."\nآیدی گروه : "..gp_id.."\nنوع چت : "..gp_type
				send_large_msg(Sudo,txt)
				if not is_sudo(msg) then
					leave_channel(get_receiver(msg),ok_cb,false)
					chat_del_user(get_receiver(msg),"user#id"..tonumber(our_id),ok_cb,true)
				end
			end
		end
	end
					

end -- end function
 
return {
patterns = {
	"^!!tgservice (chat_add_user)$"
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
