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



local function lock_group_links(msg, data, target)
 if not is_momod(msg) then
    return
  end
  local group_link_lock = data[tostring(target)]['settings']['lock_link']
  if group_link_lock == 'yes' then
    return reply_msg(msg.id,'قفل لینک فعال میباشد !\n________\nهر گونه لینک ارسالی توسط کاربران پاک خواهد شد !',ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_link'] = 'yes'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,'قفل لینک فعال شد !\n________\nاکنون ، هر گونه لینک ارسالی توسط کاربران حذف خواهد شد !',ok_cb,false)
  end
end

local function unlock_group_links(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_link_lock = data[tostring(target)]['settings']['lock_link']
  if group_link_lock == 'no' then
    return reply_msg(msg.id,'قفل لینک غیرفعال میباشد!',ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_link'] = 'no'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,'قفل لینک غیرفعال شد !',ok_cb,false)
  end
end
-------------------------------------------------------
local function lock_group_forward(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_forward_lock = data[tostring(target)]['settings']['lock_forward']
  if group_forward_lock == 'yes' then
    return reply_msg(msg.id,"قفل فروارد فعال میباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_forward'] = 'yes'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"قفل فروارد فعال شد !\n________\nهر گونه پیام فروارد شده توسط کاربران حذف خواهد شد.",ok_cb,false)
  end
end

local function unlock_group_forward(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_forward_lock = data[tostring(target)]['settings']['lock_forward']
  if group_forward_lock == 'no' then
    return reply_msg(msg.id,"قفل فروارد غیرفعال میباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_forward'] = 'no'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"قفل فروارد غیرفعال شد !",ok_cb,false)
  end
end
-------------------------------------------------------
local function lock_group_inline(msg, data, target)
	if not is_momod(msg) then
		return
	end
  local group_inline_lock = data[tostring(target)]['settings']['lock_inline']
  if group_inline_lock == 'yes' then
    return reply_msg(msg.id,"قفل کیبورد شیشه ای فعال میباشد.",ok_cb,false) 
  else
    data[tostring(target)]['settings']['lock_inline'] = 'yes'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"قفل کیبورد شیشه ای فعال شد !\n________\nهر گونه کیبورد شیشه ای ارسالی توسط کاربران حذف خواهد شد.",ok_cb,false)
  end
end

local function unlock_group_inline(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_inline_lock = data[tostring(target)]['settings']['lock_inline']
  if group_inline_lock == 'no' then
    return reply_msg(msg.id,"قفل کیبورد شیشه ای غیرفعال میباشد.",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_inline'] = 'no'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"قفل کیبورد شیشه ای در گروه غیرفعال شد !",ok_cb,false)
  end
end
-------------------------------------------------------
local function lock_group_cmd(msg, data, target)
	if not is_momod(msg) then
		return
	end
  local group_cmd_lock = data[tostring(target)]['settings']['lock_cmd']
  if group_cmd_lock == 'yes' then
    return reply_msg(msg.id,"قفل دستورات فعال میباشد !\n________\nکاربران عادی حق استفاده از دستورات معمولی بات را ندارند.",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_cmd'] = 'yes'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"قفل دستورات فعال شد !\n________\nاکنون کاربران نمیتوانند از دستورات عادی بات در گروه استفاده نمایند.",ok_cb,false)
  end
end

local function unlock_group_cmd(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_cmd_lock = data[tostring(target)]['settings']['lock_cmd']
  if group_cmd_lock == 'no' then
    return reply_msg(msg.id,"قفل دستورات فعال نمیباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_cmd'] = 'no'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"قفل دستورات غیرفعال شد !",ok_cb,false)
  end
end
-------------------------------------------------------
local function lock_group_english(msg, data, target) -- reply_msg(msg.id,"",ok_cb,false)
	if not is_momod(msg) then
		return
	end
  local group_english_lock = data[tostring(target)]['settings']['lock_english']
  if group_english_lock == 'yes' then
    return reply_msg(msg.id,"قفل انگلیسی نویسی فعال میباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_english'] = 'yes'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"قفل انگلیسی نویسی فعال شد !\n________\nهر گونه متن دارای کاراکتر های انگلیسی ارسالی توسط کاربران حذف خواهد شد.",ok_cb,false)
  end
end

local function unlock_group_english(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_english_lock = data[tostring(target)]['settings']['lock_english']
  if group_english_lock == 'no' then
    return reply_msg(msg.id,"قفل انگلیسی فعال نمیباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_english'] = 'no'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"قفل انگلیسی غیرفعال شد !",ok_cb,false)
  end
end
-------------------------------------------------------
local function lock_group_spam(msg, data, target)
	if not is_momod(msg) then
		return
	end
  local group_spam_lock = data[tostring(target)]['settings']['lock_spam']
  if group_spam_lock == 'yes' then
    return reply_msg(msg.id,"ارسال پیام طولانی در گروه ممنوع میباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_spam'] = 'yes'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"ارسال پیام طولانی در گروه ممنوع شد !\n________\nهر گونه متن طولانی حذف خواهد شد !",ok_cb,false)
  end
end

local function unlock_group_spam(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_spam_lock = data[tostring(target)]['settings']['lock_spam']
  if group_spam_lock == 'no' then
    return reply_msg(msg.id,"ارسال پیام طولانی در گروه مجاز میباشد",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_spam'] = 'no'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"ارسال پیام طولانی در گروه مجاز شد !",ok_cb,false)
  end
end
---------------------------------------------------
local function lock_group_flood(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_flood_lock = data[tostring(target)]['settings']['flood']
  if group_flood_lock == 'yes' then
    return reply_msg(msg.id,"ارسال پیام مکرر در گروه ممنوع میباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['flood'] = 'yes'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"ارسال پیام مکرر در گروه ممنوع شد !\n________\nکاربری که خلاف آن عمل کند اخراج خواهد شد !",ok_cb,false)
  end
end

local function unlock_group_flood(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_flood_lock = data[tostring(target)]['settings']['flood']
  if group_flood_lock == 'no' then
    return reply_msg(msg.id,"ارسال پیام مکرر در گروه مجاز میباشد",ok_cb,false)
  else
    data[tostring(target)]['settings']['flood'] = 'no'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"ارسال پیام مکرر در گروه مجاز شد !",ok_cb,false)
  end
end
---------------------------------------------------
local function lock_group_arabic(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_arabic_lock = data[tostring(target)]['settings']['lock_arabic']
  if group_arabic_lock == 'yes' then
    return reply_msg(msg.id,"عربی و پارسی نویسی در گروه ممنوع میباشد \n________\nهر گونه متن عربی و یا فارسی حذف خواهد شد",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_arabic'] = 'yes'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"عربی و پارسی نویسی در گروه ممنوع شد \n________\nهر گونه متن عربی و یا فارسی حذف خواهد شد",ok_cb,false) -- reply_msg(msg.id,"",ok_cb,false)
  end
end

local function unlock_group_arabic(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_arabic_lock = data[tostring(target)]['settings']['lock_arabic']
  if group_arabic_lock == 'no' then
    return reply_msg(msg.id,"عربی و فارسی نویسی در گروه مجاز میباشد",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_arabic'] = 'no'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"عربی و فارسی نویسی در گروه مجاز شد !",ok_cb,false)
  end
end
---------------------------------------------------
local function lock_group_bots(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_bots_lock = data[tostring(target)]['settings']['lock_bots']
  if group_bots_lock == 'yes' then
    return reply_msg(msg.id,'قفل ورود بات به گروه فعال میباشد !',ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_bots'] = 'yes'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,'قفل ورود بات فعال شد !\n________\nاز این به بعد ، بات های API که وارد گروه شوند به سرعت اخراج میگردند.\nبات هایی مانند خوش آمد گوها و ...',ok_cb,false)
  end
end

local function unlock_group_bots(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_bots_lock = data[tostring(target)]['settings']['lock_bots']
  if group_bots_lock == 'no' then
    return reply_msg(msg.id,'قفل ورود بات غیرفعال میباشد !',ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_bots'] = 'no'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,'قفل ورود بات به گروه غیرفعال شد !',ok_cb,false)
  end
end
---------------------------------------------------
local function lock_group_tgservice(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_tgservice_lock = data[tostring(target)]['settings']['lock_tgservice']
  if group_tgservice_lock == 'yes' then
    return reply_msg(msg.id,"حذف پیام های ورود و خروج فعال میباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_tgservice'] = 'yes'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"حذف پیام های ورود و خروج فعال شد !\n________\nهر گونه پیام مبنی بر ورود و یا خروج کاربران از گروه ، حذف خواهد شد !",ok_cb,false)
  end
end

local function unlock_group_tgservice(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_tgservice_lock = data[tostring(target)]['settings']['lock_tgservice']
  if group_tgservice_lock == 'no' then
    return reply_msg(msg.id,"حذف پیام های ورود و خروج غیرفعال میباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_tgservice'] = 'no'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"حذف پیام های ورود و خروج غیرفعال شد !",ok_cb,false)
  end
end
-----------------------------------------------------
local function enable_strict_rules(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_strict_lock = data[tostring(target)]['settings']['strict']
  if group_strict_lock == 'yes' then
    return reply_msg(msg.id,"شرایط سخت در گروه فعال میباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['strict'] = 'yes'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"شرایط سخت در گروه فعال شد !\n________\nدر صورت فعال بودن قفل لینک ، هر کاربری که از این به بعد لینکی ارسال کند ، از گروه اخراج خواهد شد .",ok_cb,false)
  end
end

local function disable_strict_rules(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_strict_lock = data[tostring(target)]['settings']['strict']
  if group_strict_lock == 'no' then
    return reply_msg(msg.id,"شرایط سخت فعال نمیباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['strict'] = 'no'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"شرایط سخت غیرفعال شد !",ok_cb,false)
  end
end
---------------------------------------------------



-- Media Locks
----------------------------------------------------
local function lock_group_audio(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_audio_lock = data[tostring(target)]['settings']['lock_audio']
  if group_audio_lock == 'yes' then
    return reply_msg(msg.id,"قفل صدا فعال میباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_audio'] = 'yes'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"قفل صدا فعال شد !\n________\nهر گونه صدا و ویس ارسالی توسط کاربران حذف خواهد شد.",ok_cb,false)
  end
end

local function unlock_group_audio(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_audio_lock = data[tostring(target)]['settings']['lock_audio']
  if group_audio_lock == 'no' then
    return reply_msg(msg.id,"قفل صدا غیرفعال میباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_audio'] = 'no'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"قفل صدا غیرفعال شد !",ok_cb,false)
  end
end
---------------------------------------------------
local function lock_group_photo(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_photo_lock = data[tostring(target)]['settings']['lock_photo']
  if group_photo_lock == 'yes' then
    return reply_msg(msg.id,"قفل تصاویر فعال میباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_photo'] = 'yes'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"قفل تصاویر فعال شد !\n________\nهر گونه تصویر ارسالی توسط کاربران حذف خواهد شد.",ok_cb,false)
  end
end

local function unlock_group_photo(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_photo_lock = data[tostring(target)]['settings']['lock_photo']
  if group_photo_lock == 'no' then
    return reply_msg(msg.id,"قفل تصاویر غیرفعال میباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_photo'] = 'no'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"قفل تصاویر غیرفعال شد !",ok_cb,false)
  end
end
---------------------------------------------------
local function lock_group_video(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_video_lock = data[tostring(target)]['settings']['lock_video']
  if group_video_lock == 'yes' then
    return reply_msg(msg.id,"قفل ویدیو فعال میباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_video'] = 'yes'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"قفل ویدیو فعال شد !\n________\nهر گونه ویدیوی ارسالی توسط کاربران حذف خواهد شد.",ok_cb,false)
  end
end

local function unlock_group_video(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_video_lock = data[tostring(target)]['settings']['lock_video']
  if group_video_lock == 'no' then
    return reply_msg(msg.id,"قفل ویدیو غیرفعال میباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_video'] = 'no'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"قفل ویدیو غیرفعال شد !",ok_cb,false)
  end
end
---------------------------------------------------
local function lock_group_documents(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_video_lock = data[tostring(target)]['settings']['lock_documents']
  if group_documents_lock == 'yes' then
    return reply_msg(msg.id,"قفل فایل فعال میباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_documents'] = 'yes'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"قفل فایل فعال شد !\n________\nهر گونه فایل ارسالی توسط کاربران حذف خواهد شد.",ok_cb,false)
  end
end

local function unlock_group_documents(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_documents_lock = data[tostring(target)]['settings']['lock_documents']
  if group_documents_lock == 'no' then
    return reply_msg(msg.id,"قفل فایل غیرفعال میباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_documents'] = 'no'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"قفل فایل غیرفعال شد !",ok_cb,false)
  end
end
---------------------------------------------------
local function lock_group_text(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_text_lock = data[tostring(target)]['settings']['lock_text']
  if group_text_lock == 'yes' then
    return reply_msg(msg.id,"قفل متن فعال میباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_text'] = 'yes'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"قفل متن فعال شد !\n________\nهر گونه متن ارسالی توسط کاربران حذف خواهد شد.",ok_cb,false)
  end
end

local function unlock_group_text(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_text_lock = data[tostring(target)]['settings']['lock_text']
  if group_text_lock == 'no' then
    return reply_msg(msg.id,"قفل متن غیرفعال میباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_text'] = 'no'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"قفل متن غیرفعال شد !",ok_cb,false)
  end
end
---------------------------------------------------
local function lock_group_gifs(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_gifs_lock = data[tostring(target)]['settings']['lock_gifs']
  if group_gifs_lock == 'yes' then
    return reply_msg(msg.id,"قفل گیف فعال میباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_gifs'] = 'yes'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"قفل گیف فعال شد !\n________\nهر گونه گیف (عکس متحرک) ارسالی توسط کاربران حذف خواهد شد.",ok_cb,false)
  end
end

local function unlock_group_gifs(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_gifs_lock = data[tostring(target)]['settings']['lock_gifs']
  if group_gifs_lock == 'no' then
    return reply_msg(msg.id,"قفل گیف غیرفعال میباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_gifs'] = 'no'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"قفل گیف غیرفعال شد !",ok_cb,false)
  end
end
---------------------------------------------------
local function lock_group_sticker(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_sticker_lock = data[tostring(target)]['settings']['lock_sticker']
  if group_sticker_lock == 'yes' then
    return reply_msg(msg.id,"قفل استیکر فعال میباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_sticker'] = 'yes'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"قفل استیکر فعال شد !\n________\nهر گونه استیکر ارسالی توسط کاربران حذف خواهد شد.",ok_cb,false)
  end
end

local function unlock_group_sticker(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_sticker_lock = data[tostring(target)]['settings']['lock_sticker']
  if group_sticker_lock == 'no' then
    return reply_msg(msg.id,"قفل استیکر غیرفعال میباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_sticker'] = 'no'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"قفل استیکر غیرفعال شد !",ok_cb,false)
  end
end
---------------------------------------------------
local function lock_group_contacts(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_contacts_lock = data[tostring(target)]['settings']['lock_contacts']
  if group_contacts_lock == 'yes' then
    return reply_msg(msg.id,"قفل ارسال مخاطب در گروه فعال میباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_contacts'] = 'yes'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"قفل ارسال مخاطب فعال شد !\n________\nهر گونه مخاطب ارسالی از طرف کاربران در گروه حذف خواهد شد !",ok_cb,false)
  end
end

local function unlock_group_contacts(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_contacts_lock = data[tostring(target)]['settings']['lock_contacts']
  if group_contacts_lock == 'no' then
    return reply_msg(msg.id,"قفل ارسال مخاطب در گروه غیرفعال میباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_contacts'] = 'no'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"قفل ارسال مخاطب غیرفعال شد !",ok_cb,false)
  end
end
---------------------------------------------------
local function lock_group_all(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_all_lock = data[tostring(target)]['settings']['lock_all']
  if group_all_lock == 'yes' then
    return reply_msg(msg.id,"قفل چت (همگانی) فعال میباشد !\n________\nچت بسته است و هر مطلب ارسالی پاک خواهد شد.",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_all'] = 'yes'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"قفل چت (همگانی) فعال شد !\n________\nچت بسته است و هر مطلب ارسالی پاک خواهد شد.",ok_cb,false)
  end
end

local function unlock_group_all(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_all_lock = data[tostring(target)]['settings']['lock_all']
  if group_all_lock == 'no' then
    return reply_msg(msg.id,"قفل چت (همگانی) غیرفعال میباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_all'] = 'no'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"قفل چت (همگانی) غیرفعال شد !\n________\nهم اکنون کاربران میتوانند به چت و گفت و گوی خود ادامه دهند.",ok_cb,false)
  end
end
-------------------------------------------------------

local function lock_group_wlc(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_wlc_lock = data[tostring(target)]['settings']['lock_wlc']
  if group_wlc_lock == 'yes' then
    return reply_msg(msg.id,"پیام خوش آمد گویی فعال میباشد !",ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_wlc'] = 'yes'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,"پیام خوش آمد گویی فعال شد !\n________\nبه کسانی که از طریق لینک وارد گروه شوند ، خوش آمد گفته میشود !",ok_cb,false)
  end
end

local function unlock_group_wlc(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_wlc_lock = data[tostring(target)]['settings']['lock_wlc']
  if group_wlc_lock == 'no' then
    return reply_msg(msg.id,'پیام خوش آمد گویی غیر فعال میباشد !',ok_cb,false)
  else
    data[tostring(target)]['settings']['lock_wlc'] = 'no'
    save_data(_config.moderation.data, data)
    return reply_msg(msg.id,'پیام خوش آمد گویی غیرفعال شد !',ok_cb,false)
  end
end

-----------------------------------------------------
--End supergroup locks

--Show supergroup settings; function
function show_supergroup_settingsmod(msg, target)
 	if not is_momod(msg) then
    	return
  	end
	local data = load_data(_config.moderation.data)
    if data[tostring(target)] then
     	if data[tostring(target)]['settings']['flood_msg_max'] then
        	NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['flood_msg_max'])
        	print('custom'..NUM_MSG_MAX)
      	else
        	NUM_MSG_MAX = 5
      	end
    end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['public'] then
			data[tostring(target)]['settings']['public'] = 'no'
		end
	end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_rtl'] then
			data[tostring(target)]['settings']['lock_rtl'] = 'no'
		end
	end
      if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_tgservice'] then
			data[tostring(target)]['settings']['lock_tgservice'] = 'no'
		end
	end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_member'] then
			data[tostring(target)]['settings']['lock_member'] = 'no'
		end
	end
	local settings = data[tostring(target)]['settings']
  
  ---- Expire Time
	local expiretime = redis:hget('expiretime', get_receiver(msg))
		if not expiretime then
			expire = "نامحدود !"
		else
			local now = tonumber(os.time())
			ex =  math.floor((tonumber(expiretime) - tonumber(now)) / 86400) + 1
			expire = ex..' روز دیگر'
		end
  -----
  
	nams = msg.to.print_name:gsub("_"," ")
	local text = "👥 نام گروه : "..nams.."\n⚜ آیدی گروه : "..msg.to.id.."\n\n⛔️ قفل های اصلی :\n________\n🔗 قفل لینک : "..settings.lock_link.."\n➡️ قفل فروارد : "..settings.lock_forward.."\n⌨ قفل کیبورد شیشه ای : "..settings.lock_inline.."\n🖥 قفل دستورات : "..settings.lock_cmd.."\n🔶 قفل انگلیسی :"..settings.lock_english.."\n🔷 قفل پارسی و عربی : "..settings.lock_arabic.."\n🔖 قفل پیام های طولانی : "..settings.lock_spam.."\n☠ قفل پیام های مکرر : "..settings.flood.."\n🔧 حساسیت پیام های مکرر : "..NUM_MSG_MAX.."\n🤖 قفل ورود بات : "..settings.lock_bots.."\n💼 حذف پیام ورود و خروج : "..settings.lock_tgservice.."\n________\n\n\n🗂 قفل های رسانه ای :\n________\n🔊 قفل صدا : "..settings.lock_audio.."\n🌅 قفل تصاویر : "..settings.lock_photo.."\n🎥 قفل ویدیو : "..settings.lock_video.."\n📥 قفل فایل ها : "..settings.lock_documents.."\n📋 قفل متن : "..settings.lock_text.."\n☂ قفل گیف ها : "..settings.lock_gifs.."\n🚏 قفل استیکر : "..settings.lock_sticker.."\n📍 قفل ارسال مخاطب : "..settings.lock_contacts.."\n_________\n\n\n💢 قفل های مهم :\n________\n♨️ شرایط سخت : "..settings.strict.."\n🚫 قفل چت (همگانی) : "..settings.lock_all.."\n________\n📬 پیام خوش آمد گویی :"..(settings.lock_wlc or " نیاز به فعالسازی اولیه").."\n🔃 انقضای گروه : "..expire
   
	text = text:gsub("yes","✅")
	text = text:gsub("no","❌")
   
	return reply_msg(msg.id,text,ok_cb,false)
end


function run(msg,matches)
		
		data = load_data(_config.moderation.data)
		
		if not is_momod(msg) then
			return
		end
		
		if matches[1] == 'قفل' or matches[1]:lower() == 'lock' then
			local target = msg.to.id
			
			if matches[2] == 'لینک' or matches[2]:lower() == 'link' or matches[2]:lower() == 'links' then
				return lock_group_links(msg, data, target)
			end
			
			if matches[2] == 'فروارد' or matches[2]:lower() == 'forward' then
				return lock_group_forward(msg, data, target)
			end
			
			if matches[2] == 'ربات' or matches[2] == 'بات' or matches[2]:lower() == 'bot' or matches[2]:lower() == 'bots' then
				return lock_group_bots(msg, data, target)
			end
			
			if matches[2] == 'کیبورد' or matches[2]:lower() == 'inline' then
				return lock_group_inline(msg, data, target)
			end
			
			if matches[2] == 'دستورات' or matches[2]:lower() == 'cmd' then
				return lock_group_cmd(msg, data, target)
			end
			
			if matches[2] == 'انگلیسی' or matches[2]:lower() == 'english' then
				return lock_group_english(msg, data, target)
			end
			
			if matches[2] == 'اسپم' or matches[2]:lower() == 'spam' then
				return lock_group_spam(msg, data, target)
			end
			
			if matches[2] == 'رگباری' or matches[2]:lower() == 'flood' then
				return lock_group_flood(msg, data, target)
			end
			
			if matches[2] == 'فارسی' or matches[2]:lower() == 'persian' then
				return lock_group_arabic(msg, data, target)
			end
			
			if matches[2] == 'خدمات' or matches[2]:lower() == 'tgservice' or matches[2]:lower() == 'service' or matches[2]:lower() == 'tg' then
				return lock_group_tgservice(msg, data, target)
			end
			
			if matches[2] == 'سخت' or matches[2]:lower() == 'strict' then
				return enable_strict_rules(msg, data, target)
			end
			---------------
			if matches[2] == 'صدا' or matches[2]:lower() == 'audio' or matches[2]:lower() == 'voice' then
				return lock_group_audio(msg, data, target)
			end
			
			if matches[2] == 'عکس' or matches[2] == 'تصاویر' or matches[2]:lower() == 'photo' or matches[2]:lower() == 'pic' then
				return lock_group_photo(msg, data, target)
			end
			
			if matches[2] == 'ویدیو' or matches[2]:lower() == 'video' then
				return lock_group_video(msg, data, target)
			end
			
			if matches[2] == 'فایل' or matches[2]:lower() == 'file' or matches[2]:lower() == 'document' then
				return lock_group_documents(msg, data, target)
			end
			
			if matches[2] == 'متن' or matches[2]:lower() == 'text' then
				return lock_group_text(msg, data, target)
			end
			
			if matches[2] == 'گیف' or matches[2]:lower() == 'gif' or matches[2] == 'gifs' then
				return lock_group_gifs(msg, data, target)
			end
			
			if matches[2] == 'استیکر' or matches[2]:lower() == 'sticker' then
				return lock_group_sticker(msg, data, target)
			end
			
			if matches[2] == 'مخاطب' or matches[2]:lower() == 'contact' or matches[2]:lower() == 'contacts' then
				return lock_group_contacts(msg, data, target)
			end
			
			if matches[2] == 'همه' or matches[2] == 'چت' or matches[2]:lower() == 'chat' or matches[2]:lower() == 'all' then
				return lock_group_all(msg, data, target)
			end
			--
			if matches[2] == 'خوش آمد' or matches[2] == 'خوشامد' or matches[2] == 'خوش امد' or matches[2]:lower() == 'welcome' or matches[2]:lower() == 'wlc' then
				return lock_group_wlc(msg, data, target)
			end
			
		end -- end lock

		if matches[1] == 'بازکردن' or matches[1]:lower() == 'unlock' then
			local target = msg.to.id
			
			if matches[2] == 'لینک' or matches[2]:lower() == 'link' or matches[2]:lower() == 'links' then
				return unlock_group_links(msg, data, target)
			end
			
			if matches[2] == 'فروارد' or matches[2]:lower() == 'forward' or matches[2]:lower() == "fwd" then
				return unlock_group_forward(msg, data, target)
			end
			
			if matches[2] == 'ربات' or matches[2] == 'بات' or matches[2]:lower() == 'bot' or matches[2] == "bots" then
				return unlock_group_bots(msg, data, target)
			end
			
			if matches[2] == 'کیبورد' or matches[2]:lower() == 'inline' then
				return unlock_group_inline(msg, data, target)
			end
			
			if matches[2] == 'دستورات' or matches[2]:lower() == 'cmd' or matches[2]:lower() == "cmds" then
				return unlock_group_cmd(msg, data, target)
			end
			
			if matches[2] == 'انگلیسی' or matches[2]:lower() == 'english' then
				return unlock_group_english(msg, data, target)
			end
			
			if matches[2] == 'اسپم' or matches[2]:lower() == 'spam' then
				return unlock_group_spam(msg, data, target)
			end
			
			if matches[2] == 'رگباری' or matches[2]:lower() == 'flood' then
				return unlock_group_flood(msg, data, target)
			end
			
			if matches[2] == 'فارسی' or matches[2]:lower() == 'persian' then
				return unlock_group_arabic(msg, data, target)
			end
			
			if matches[2] == 'خدمات' or matches[2]:lower() == 'tgservice' or matches[2]:lower() == 'service' or matches[2]:lower() == 'tg' then
				return unlock_group_tgservice(msg, data, target)
			end
			
			if matches[2] == 'سخت' or matches[2]:lower() == 'strict' then
				return disable_strict_rules(msg, data, target)
			end
			---------------
			if matches[2] == 'صدا' or matches[2]:lower() == 'audio' or matches[2]:lower() == 'voice' then
				return unlock_group_audio(msg, data, target)
			end
			
			if matches[2] == 'عکس' or matches[2]:lower() == 'تصاویر' or matches[2]:lower() == 'photo' or matches[2]:lower() == 'pic' then
				return unlock_group_photo(msg, data, target)
			end
			
			if matches[2] == 'ویدیو' or matches[2]:lower() == 'video' then
				return unlock_group_video(msg, data, target)
			end
			
			if matches[2] == 'فایل' or matches[2]:lower() == 'file' or matches[2]:lower() == 'document' then
				return unlock_group_documents(msg, data, target)
			end
			
			if matches[2] == 'متن' or matches[2]:lower() == 'text' then
				return unlock_group_text(msg, data, target)
			end
			
			if matches[2] == 'گیف' or matches[2]:lower() == 'gif' or matches[2]:lower() == 'gifs' then
				return unlock_group_gifs(msg, data, target)
			end
			
			if matches[2] == 'استیکر' or matches[2]:lower() == 'sticker' then
				return unlock_group_sticker(msg, data, target)
			end
			
			if matches[2] == 'مخاطب' or matches[2]:lower() == 'contact' or matches[2]:lower() == 'contacts' then
				return unlock_group_contacts(msg, data, target)
			end
			
			if matches[2] == 'همه' or matches[2] == 'چت' or matches[2]:lower() == 'chat' or matches[2]:lower() == 'all' then
				return unlock_group_all(msg, data, target)
			end
			--
			if matches[2] == 'خوش آمد' or matches[2] == 'خوشامد' or matches[2] == 'خوش امد' or matches[2]:lower() == 'welcome' or matches[2]:lower() == 'wlc' then
				return unlock_group_wlc(msg, data, target)
			end
			
		end -- end unlock
		
		
		if matches[1] == 'تنظیمات' or matches[1]:lower() == "setting" or matches[1]:lower() == "settings" then
			local target = msg.to.id
			return show_supergroup_settingsmod(msg, target)
		end
		
		
		if matches[1] == 'تنظیم رگباری' or matches[1]:lower() == "setflood" then
			if tonumber(matches[2]) < 5 or tonumber(matches[2]) > 20 then
				return "عدد انتخاب شده اشتباه است باید بین 5 تا 20 باشد"
			end
			local flood_max = matches[2]
			data[tostring(msg.to.id)]['settings']['flood_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
			return reply_msg(msg.id,'حساسیت اسپم تغییر یافت به : '..matches[2],ok_cb,false)
		end
		
end


return {
patterns = {
	
	-- locks and unlocks
	"^(قفل) (.*)$",
	"^(بازکردن) (.*)$",
	"^[/!#]([Ll][Oo][Cc][Kk]) (.*)",
	"^[/!#]([Uu][Nn][Ll][Oo][Cc][Kk]) (.*)",
	
	-- show settings
	"^(تنظیمات)$",
	"^[/!#]([Ss][Ee][Tt][Tt][Ii][Nn][Gg])$",
	"^[/!#]([Ss][Ee][Tt][Tt][Ii][Nn][Gg][Ss])$",
	
	-- set flood
	"^(تنظیم رگباری) (%d+)$",
	"^[/!#]([Ss][Ee][Tt][Ff][Ll][Oo][Oo][Dd]) (%d+)$"
	
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