local function pre_process(msg)
	local chkfosh = redis:hget('settings:fosh',msg.chat_id_)
	if not chkfosh then
		redis:hset('settings:fosh',msg.chat_id_,'off')
	end
end

local function run(msg, matches)
--code By @lock_at_me_now & @THS_56
	if matches[1]:lower() == 'unlock' then
		if matches[2]:lower() == 'fosh' then
			if not is_mod(msg) then return end
			local fosh = redis:hget('settings:fosh',msg.chat_id_)
			if fosh == 'on' then 
				redis:hset('settings:fosh',msg.chat_id_,'off')
				return ''
			elseif fosh == 'off' then
				return ''
			end
		end
	end
	if matches[1]:lower() == 'lock' then
		if matches[2]:lower() == 'fosh' then
			if not is_mod(msg) then return end
			local fosh = redis:hget('settings:fosh',msg.chat_id_)
			if fosh == 'off' then 
				redis:hset('settings:fosh',msg.chat_id_,'on')
				return ''
			elseif fosh == 'on' then
				return ''
			end
		end
	end
	if not is_mod(msg) then
		local fosh = redis:hget('settings:fosh',msg.chat_id_)
		if fosh == 'on' then 
			tdcli.deleteMessages(msg.chat_id_, {[0] = msg.id_}, dl_cb, nil)	
		end
	end
end
 
return {
  patterns = {
    "(كسمك)$",
    "عير",
	"كس",
	"سني",
	"شيعي",
	"خرب بربك",
    "كمبي",
	"كوم بي",
	"بلاع",
	"fuck",
 "shit",
	"pusyy",
	"سكسي",
	"سكس",
	"sexy",
	"بعثي",
	"شيعية",
	"شيعيه",
	"انهض بي",
	"خرب الله",
	"عير بيك",
	"كسختك",
	"كس اختك",
	"كس امك",
	"اخت التنيج",
	"تنح",
	"تنحي",
	"كسمج",
	"كس امج",
"كسك",
	"كسج",
	"كس عمتك",
	"كس خالتك",
"كس عمتك",
	"كسعمتك",
	"انعل ابوك",
	"انعل ابوج",
	"كس ربك",
	"كس ربج",
	"انعل ربك",
	"انعل ربج",
	"خرب بربج",
	"كسخت المطور",
	"كس اخت المطور",
	"كسم المطور",
	"كس ام المطور",
	"عير بختك",
	"عير بمك",

	--Commands Don't channnnge this ();
	"^[!/#]([Ll][Oo][Cc][Kk]) (.*)$",
	"^[!/#]([Uu][Nn][Ll][Oo][Cc][Kk]) (.*)$",

  },
  run = run,
  pre_process = pre_process
}

--code By @lock_at_me_now & @THS_56
--code By @lock_at_me_now & @THS_56
--code By @lock_at_me_now & @THS_56
--code By @lock_at_me_now & @THS_56
--code By @lock_at_me_now & @THS_56