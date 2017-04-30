local function pre_process(msg)
 msg.text = msg.content_.text
	local timetoexpire = 'unknown'
	local expiretime = redis:hget ('expiretime', msg.chat_id_)
	local now = tonumber(os.time())
	if expiretime then    
		timetoexpire = math.floor((tonumber(expiretime) - tonumber(now)) / 86400) + 1
		if tonumber("0") > tonumber(timetoexpire) and not is_sudo(msg) then
		if msg.text:match('/') then
			return tdcli.sendMessage(msg.chat_id_, 0, 1, '*ExpireTime Ended.*', 1, 'md')
		else
			return
		end
	end
	if tonumber(timetoexpire) == 0 then
		if redis:hget('expires0',msg.chat_id_) then end
		tdcli.sendMessage(msg.chat_id_, 0, 1, '*⚠️ لقد انتهى وقت بقائي هنا يرجى على مدير المجموعه التوجه الى احد المطورين 
@lock_at_me_now & @THS_56 *.', 1, 'md')
		redis:hset('expires0',msg.chat_id_,'5')
	end
	if tonumber(timetoexpire) == 1 then
		if redis:hget('expires1',msg.chat_id_) then end
		tdcli.sendMessage(msg.chat_id_, 0, 1, '*⚠️باقي يوم واحد لانتهاء مده مغادرتي المجموعة يرجى الاتجاه الى المطورين لتجديد المدة 
@lock_at_me_now & @THS_56 *.', 1, 'md')
		redis:hset('expires1',msg.chat_id_,'5')
	end

end

end
function run(msg, matches)
	if matches[1]:lower() == 'setexpire' then
		if not is_sudo(msg) then return end
		local time = os.time()
		local buytime = tonumber(os.time())
		local timeexpire = tonumber(buytime) + (tonumber(matches[2]) * 86400)
		redis:hset('expiretime',msg.chat_id_,timeexpire)
		return "✏Group name"..msg.to.title.."\n *لقد تم تعيين * _"..matches[2].. "_ *يوم* "
	end
	if matches[1]:lower() == 'expire' then
		local expiretime = redis:hget ('expiretime', msg.chat_id_)
		if not expiretime then return '*Unlimited*' else
			local now = tonumber(os.time())
			return (math.floor((tonumber(expiretime) - tonumber(now)) / 86400) + 1) .. " *الأيام المتبقية 📅* MSG BY:"..msg.from.first_name
		end
	end

end
return {
  patterns = {
    "^[!#/]([Ss]etexpire) (.*)$",
	"^[!#/]([Ee]xpire)$",
  },
  run = run,
  pre_process = pre_process
}
-- http://bom_bang_team