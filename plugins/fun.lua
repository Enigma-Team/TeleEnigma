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


-----------------------------------------------------------------------------------
function run(msg, matches)

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

	-- دریافت زمان
	if matches[1] == "زمان" or matches[1]:lower() == "time" then
	
		local url , res = http.request('http://api.gpmod.ir/time/')
		if res ~= 200 then return end
		local jd = json:decode(url)
		
		return reply_msg(msg.id,"🗓 امروز : "..jd.FAdate.."\n⏰ ساعت : "..jd.FAtime.."\n\n🗓<b>Today : "..jd.ENdate.."\n⏰ Time : "..jd.ENtime.."  </b>",ok_cb,false)
	end
	
	-- ساخت گیف
	if matches[1] == "گیف" or matches[1]:lower() == "gif" then 
		if matches[2] then
			text = URL.escape(matches[2])
			url2 = 'http://www.flamingtext.com/net-fu/image_output.cgi?_comBuyRedirect=false&script=blue-fire&text='..text..'&symbol_tagname=popular&fontsize=70&fontname=futura_poster&fontname_tagname=cool&textBorder=15&growSize=0&antialias=on&hinting=on&justify=2&letterSpacing=0&lineSpacing=0&textSlant=0&textVerticalSlant=0&textAngle=0&textOutline=off&textOutline=false&textOutlineSize=2&textColor=%230000CC&angle=0&blueFlame=on&blueFlame=false&framerate=75&frames=5&pframes=5&oframes=4&distance=2&transparent=off&transparent=false&extAnim=gif&animLoop=on&animLoop=false&defaultFrameRate=75&doScale=off&scaleWidth=240&scaleHeight=120&&_=1469943010141'
			title , res = http.request(url2)
			jdat = json:decode(title)
			gif = jdat.src
			file = download_to_file(gif,'t2g.gif')
				send_document(get_receiver(msg), file, ok_cb, false)
		end
	end
	
	-- کوتاه کردن لینک
	if matches[1] == "کوتاه" or matches[1]:lower() == "short" then
		if matches[2] then
			if string.match(matches[2],"^[Hh][Tt][Tt][Pp]://") or string.match(matches[2],"^[Hh][Tt][Tt][Pp][Ss]://") then
				local yeo = http.request('http://yeo.ir/api.php?url='..URL.escape(matches[2]))
				local opizo = http.request('http://api.gpmod.ir/shorten/?url='..URL.escape(matches[2])..'&username=rezamehdpour@gmail.com')

				return reply_msg(msg.id,'لینک مورد نظر :\n'..matches[2]..'\n\n━━━━━━━━━━\nلینک کوتاه شده با Opizo :\n'..opizo..'\n━━━━━━━━━━\nلینک کوتاه شده با Yeo :\n'..yeo..'\n━━━━━━━━━━━\n» [ @EnigmaTM ] «',ok_cb,false)
		
			else
		
				return reply_msg(msg.id,"فرمت لینک شما صحیح نمیباشد !\nلینک شما باید یکی از پیشوند های زیر را در ابتدای خود دارا باشد :\nhttp://\nhttps://",ok_cb,false)
		
			end
		end
		
	end
	
	
	-- گرفتن فال حافظ
	if matches[1] == "فال" or matches[1]:lower() == "fal" then
	
		local database = 'http://vip.opload.ir/vipdl/95/1/amirhmz/'
		local res = http.request(database.."fal.db")
		local fal = res:split(",")
		local fal = fal[math.random(#fal)]
				txt = "🎭 فال شما :\n━━━━━━━━━━━━━━━━━━━━━━━━\n"..fal.."\n━━━━━━━━━━━━\n» [ @EnigmaTM ] «"
		return reply_msg(msg.id,txt,ok_cb,false)
	end
	
	
	-- دریافت معنی یک کلمه
	if matches[1] == "ترجمه" or matches[1]:lower() == "tr" then 
	
		url = https.request('https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20160119T111342Z.fd6bf13b3590838f.6ce9d8cca4672f0ed24f649c1b502789c9f4687a&format=plain&lang=fa&text='..URL.escape(matches[2])) 
		data = json:decode(url)
		txt = '🏷 عبارت اولیه : '..matches[2]..'\n🎙 زبان ترجمه : '..data.lang..'\n\n📝 ترجمه : '..data.text[1]
			return reply_msg(msg.id,txt,ok_cb,false)
			
	end 
	
	-- دریافت اخبار
	if matches[1] == "اخبار" or matches[1]:lower() == "news" then 
		local url = http.request('http://api.avirateam.ir/irna/cli/index.php?pass=dN@-Sy1k$mKB2PgWoj)7/9vbDL0VCpfA')
		url = string.gsub(url,"اطلاعات بیشتر","لینک خبر")
		return reply_msg(msg.id,url,ok_cb,false)
	end 
	
	
	-- اخبار موبایل
	if matches[1] == "موبایل" or matches[1]:lower() == "mobile" then 
		local pass = 'dram1135' 
		local url = 'http://api.avirateam.ir/mobile/cli/index.php?pass='..pass 
		local req = http.request(url) 
			req = req:gsub("Powered By http://www.mobile.ir","━━━━━━━━━━━━\n» [ @EnigmaTM ] «")
			req = req:gsub("اطلاعات بیشتر","لینک")
			req = req:gsub("🆕 لیست جدیدترین گوشی ها :","🔍 جدیدترین موبایل ها :\n━━━━━━━━━━━━━━━")
			return reply_msg(msg.id,req,ok_cb,false)
	end
	
	

	
----------------------------------------------------------
end


return {
patterns = {
	"^(زمان)$",
	"^[/!#]([Tt][Ii][Mm][Ee])$",
	
	"^(گیف) (.*)",
	"^[/!#]([Gg][Ii][Ff]) (.*)",
	
	"^(کوتاه) (.*)",
	"^[/!#]([Ss][Hh][Oo][Rr][Tt]) (.*)",
	
	"^(فال)$",
	"^[/!#]([Ff][Aa][Ll])$",
	
	"^(ترجمه) (.*)",
	"^[/!#]([Tt][Rr]) (.*)",
	
	"^(اخبار)$",
	"^[/!#]([Nn][Ee][Ww][Ss])$",
	
	"^(موبایل)$",
	"^[/!#]([Mm][Oo][Bb][Ii][Ll][Ee])$"
	
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