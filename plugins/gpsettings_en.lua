local function modadd(msg)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
    if not is_admin(msg) then
   if not lang then
        return '_You are not bot admin_'
else
     return 'أنت لست مشرف في البوت'
    end
end
    local data = load_data(_config.moderation.data)
  if data[tostring(msg.chat_id_)] then
if not lang then
   return '*Group name*'..msg.to.title..'\n _♻️Group is already added♻️_\n `MSG By:` (@'..msg.from.username or')'..msg.from.first_name
else
return '*Group name*'..msg.to.title..'\n البوت مضاف للمجموعه مسبقا♻\n `MSG By:` (@'..msg.from.username or')'..msg.from.first_name
  end
end
        -- create data array in moderation.json
      data[tostring(msg.chat_id_)] = {
              owners = {},
      mods ={},
      banned ={},
      is_silent_users ={},
      filterlist ={},
      settings = {
          lock_link = 'yes',
          lock_tag = 'yes',
		  lock_fuck = 'yes',
          lock_spam = 'no',
          lock_webpage = 'yes',
		  lock_arabic = 'no',
          lock_markdown = 'yes',
          flood = 'yes',
          lock_bots = 'yes',
          welcome = 'yes',
          lock_forward = 'no',
          lock_audio = 'no',
          lock_video = 'no',
          lock_contact = 'no',
          lock_text = 'no',
          lock_photos = 'no',
          lock_gif = 'no',
          lock_location = 'no',
          lock_document = 'no',
          lock_sticker = 'no',
          lock_voice = 'no',
          lock_all = 'no'
          }
      }
  save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.chat_id_)] = msg.chat_id_
      save_data(_config.moderation.data, data)
    if not lang then
  return '*Group name*'..msg.to.title..'\n *✔️Group has been added✔️* \n `MSG By:` (@'..msg.from.username or')'..msg.from.first_name
else
  return '*Group name*'..msg.to.title..'\n تم اضافة البوت الى المجموعة 💡\n `MSG By:` (@'..msg.from.username or')'..msg.from.first_name
end
end

local function modrem(msg)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
      if not is_admin(msg) then
     if not lang then
        return '_You are not bot admin_\n`MSG By:` (@'..msg.from.username or')'..msg.from.first_name
   else
        return 'انت لست مشرفا في البوت❌ \n `MSG By:`(@'..msg.from.username or')'..msg.from.first_name
    end
   end
    local data = load_data(_config.moderation.data)
    local receiver = msg.chat_id_
  if not data[tostring(msg.chat_id_)] then
  if not lang then
    return '*Group name*'..msg.to.title..'\n _Group is not added_\n `MSG By:` (@'..msg.from.username or')'..msg.from.first_name
else
    return '*Group name*'..msg.to.title..'\nالبوت غير مضاف ❌\n `By:` (@'..msg.from.username or')'..msg.from.first_name
   end
  end

  data[tostring(msg.chat_id_)] = nil
  save_data(_config.moderation.data, data)
     local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end data[tostring(groups)][tostring(msg.chat_id_)] = nil
      save_data(_config.moderation.data, data)
 if not lang then
  return '*Group name*'..msg.to.title..'\n*Group has been removed*\n `MSG By:` (@'..msg.from.username or')'..msg.from.first_name
 else
  return '*Group name*'..msg.to.title..'\n تم ازاله البوت من المجموعه📛 \n `MSG By:` (@'..msg.from.username or')'..msg.from.first_name
end
end

local function filter_word(msg, word)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
  if not data[tostring(msg.chat_id_)]['filterlist'] then
    data[tostring(msg.chat_id_)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
if data[tostring(msg.chat_id_)]['filterlist'][(word)] then
   if not lang then
         return "_Word_ *"..word.."* _is already filtered_ \n `MSG By:` (@"..msg.from.username or")"..msg.from.first_name
            else
         return "_كلمة_*"..word.."* _الكلمه مكرره_ \n `MSG By:` (@"..msg.from.username or")"..msg.from.first_name
    end
end
   data[tostring(msg.chat_id_)]['filterlist'][(word)] = true
     save_data(_config.moderation.data, data)
   if not lang then
         return "_Word_ *"..word.."* _added to filtered words list_ \n `MSG By:` (@"..msg.from.username or")"..msg.from.first_name
            else
         return "_کلمه_ *"..word.."* _لقد تم اضافة كلمه الى لائحه الكلمات_ \n `MSG By:` (@"..msg.from.username or")"..msg.from.first_name
    end
end

local function unfilter_word(msg, word)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 local data = load_data(_config.moderation.data)
  if not data[tostring(msg.chat_id_)]['filterlist'] then
    data[tostring(msg.chat_id_)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
      if data[tostring(msg.chat_id_)]['filterlist'][word] then
      data[tostring(msg.chat_id_)]['filterlist'][(word)] = nil
       save_data(_config.moderation.data, data)
       if not lang then
         return "_Word_ *"..word.."* _removed from filtered words list_ \n `MSG By:` (@"..msg.from.username or")"..msg.from.first_name
       elseif lang then
         return "_کلمه_ *"..word.."* _لقد تم ازاله الكلمه_ \n `MSG By:` (@"..msg.from.username or")"..msg.from.first_name
     end
      else
       if not lang then
         return "_Word_ *"..word.."* _is not filtered_ \n `MSG By:` (@"..msg.from.username or")"..msg.from.first_name
       elseif lang then
         return "_کلمه_ *"..word.."* _هذه الكلمه ليست موجوده_ \n `MSG By:` (@"..msg.from.username or")"..msg.from.first_name
      end
   end
end

local function modlist(msg)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.chat_id_)] then
  if not lang then
    return "*Group name*"..msg.to.title.."\n _Group is not added_ \n `MSG By:` (@"..msg.from.username or")"..msg.from.first_name
 else
    return "*Group name*"..msg.to.title.."\n لم يتم اضافة البوت الى المجموعه📛 \n `MSG By:` (@"..msg.from.username or")"..msg.from.first_name
  end
 end
  -- determine if table is empty
  if next(data[tostring(msg.chat_id_)]['mods']) == nil then --fix way
  if not lang then
    return "_No_ *moderator* _in this group_ \n `MSG By:` (@"..msg.from.username or")"..msg.from.first_name
else
   return "لا يوجد حاليا أي مسؤول عن المجموعة
❎ \n `MSG By:` (@"..msg.from.username or")"..msg.from.first_name
  end
end
if not lang then
   message = '`Group name:`'..msg.to.title..'\n*List of moderators :*\n'
else
   message = '`Group name:`'..msg.to.title..'\n*قائمه المشرفين :*\n'
end
  for k,v in pairs(data[tostring(msg.chat_id_)]['mods'])
do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function ownerlist(msg)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.chat_id_)] then
if not lang then
    return "*Group name*"..msg.to.title.."\n _Group is not added_ \n `MSG By:` (@"..msg.from.username or")"..msg.from.first_name
else
return "*Group name*"..msg.to.title.."\n لم يتم اضافة البوت الى المجموعة 📛\n `MSG By:` (@"..msg.from.username or")"..msg.from.first_name
  end
end
  -- determine if table is empty
  if next(data[tostring(msg.chat_id_)]['owners']) == nil then --fix way
 if not lang then
    return "*Group name*"..msg.to.title.."\n _No_ *owner* _in this group_"
else
    return "*Group name*"..msg.to.title.."\n لا يوجد مدراء في هذه المجموعه❎"
  end
end
if not lang then
   message = '`Group name:`'..msg.to.title..'\n*List of moderators :*\n'
else
   message = '`Group name:`'..msg.to.title..'\n*قائمه المشرفين :*\n'
end
  for k,v in pairs(data[tostring(msg.chat_id_)]['owners']) do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function action_by_reply(arg, data)
local hash = "gp_lang:"..data.chat_id_
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
if not tonumber(data.sender_user_id_) then return false end
    if data.sender_user_id_ then
  if not administration[tostring(data.chat_id_)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "*Group name*"..msg.to.title.."\n _Group is not added_ \n `MSG By:` (@"..msg.from.username or")"..msg.from.first_name, 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "*Group name*"..msg.to.title.."\n _لم يتم اضافة البوت الى المجموعة _ \n `MSG By:` (@"..msg.from.username or")"..msg.from.first_name, 0, "md")
     end
  end
if cmd == "setowner" then
local function owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *group owner*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *هو بالفعل مالك للمجموعة*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now the_ *group owner*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *هو الآن مالك المجموعة*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "promote" then
local function promote_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *moderator*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *هو مشرف بالفعل *", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *promoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *لقد تمت الترقيه بنجاح*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, promote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
     if cmd == "remowner" then
local function rem_owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *group owner*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *انهُ ليس مالك المجموعة*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer a_ *group owner*", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *لم يعد مالك المجموعة*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, rem_owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "demote" then
local function demote_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *moderator*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *ليس مشرفا*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *demoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *لقد تمت الازالة*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, demote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "id" then
local function id_cb(arg, data)
    return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, id_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
else
    if lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "_المستخدم غير موجود_", 0, "md")
   else
  return tdcli.sendMessage(data.chat_id_, "", 0, "*User Not Found*", 0, "md")
      end
   end
end

local function action_by_username(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "_Group is not added_\n `MSG By:` (@"..msg.from.username or")"..msg.from.first_name, 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_لم يتم اضافة البوت الى المجموعة_ \n `MSG By:` (@"..msg.from.username or")"..msg.from.first_name, 0, "md")
     end
  end
if not arg.username then return false end
   if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
if cmd == "setowner" then
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *group owner*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *بالفعل انهُ مدير المجموعه*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now the_ *group owner*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *لقد تم تعيين مدير للمجموعه*", 0, "md")
   end
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *moderator*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *بالفعل انهُ مشرف في المجموعة*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *promoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *لقد تمت الترقيه الى مشرف*", 0, "md")
   end
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *group owner*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *ليس مالك مجموعة*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer a_ *group owner*", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *لم يعد مالك المجموعة*", 0, "md")
   end
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *moderator*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *انه ليس مشرفا*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *demoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *لقد تمت الازالة*", 0, "md")
   end
end
   if cmd == "id" then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
    if cmd == "res" then
    if not lang then
     text = "Result for [ ".. check_markdown(data.type_.user_.username_) .." ] :\n"
    .. "".. check_markdown(data.title_) .."\n"
    .. " [".. data.id_ .."]"
  else
     text = "معلومات عن [ ".. check_markdown(data.type_.user_.username_) .." ] :\n"
    .. "".. check_markdown(data.title_) .."\n"
    .. " [".. data.id_ .."]"
       return tdcli.sendMessage(arg.chat_id, 0, 1, text, 1, 'md')
      end
   end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم غير موجود_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*User Not Found*", 0, "md")
      end
   end
end

local function action_by_id(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "_Group is not added_\n `MSG By:` (@"..msg.from.username or")"..msg.from.first_name, 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_لم يتم اضافة البوت الى المجموعة_\n `MSG By:` (@"..msg.from.username or")"..msg.from.first_name, 0, "md")
     end
  end
if not tonumber(arg.user_id) then return false end
   if data.id_ then
if data.first_name_ then
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if cmd == "setowner" then
  if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *group owner*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *انهُ مالك المجموعة بالفعل*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now the_ *group owner*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."*لقد اصبح الان مالكا للمجموعة*", 0, "md")
   end
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *moderator*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *انهُ مشرف بالفعل*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *promoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *لقد تمت الترقية *", 0, "md")
   end
end

   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *group owner*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* ليس مالك المجموعه*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer a_ *group owner*", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *لم يعد مالك المجموعة*", 0, "md")
   end
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *moderator*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *انهُ ليس مشرفا*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *demoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *لقد تمت الازالة*", 0, "md")
   end
end
    if cmd == "whois" then
if data.username_ then
username = '@'..check_markdown(data.username_)
else
if not lang then
username = 'not found'
 else
username = 'لا يوجد 📛'
  end
end
     if not lang then
       return tdcli.sendMessage(arg.chat_id, 0, 1, 'Info for [ '..data.id_..' ] :\nUserName : '..username..'\nName : '..data.first_name_, 1)
   else
       return tdcli.sendMessage(arg.chat_id, 0, 1, 'معلومات عن [ '..data.id_..' ] :\nاسم المستخدم : '..username..'\nالاسم : '..data.first_name_, 1)
      end
   end
 else
    if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User not founded_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم غير موجود_", 0, "md")
    end
  end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم غير موجود_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*User Not Found*", 0, "md")
      end
   end
end


---------------Lock Link-------------------
local function lock_link(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end

local lock_link = data[tostring(target)]["settings"]["lock_link"] 
if lock_link == "yes" then
if not lang then
 return "🔐*Link* _Posting Is Already Locked_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
 return "تم قفل الروابط من قبل♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else
data[tostring(target)]["settings"]["lock_link"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "🔐*Link* _Posting Has Been Locked_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
else
 return "لقد تم قفل الروابط بنجاح 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

local function unlock_link(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end 

local lock_link = data[tostring(target)]["settings"]["lock_link"]
 if lock_link == "no" then
if not lang then
return "🔓*Link* _Posting Is Not Locked_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
return "قفل الروابط غير فعال مسبقا 📛 \n `MSG BY:` *"..msg.from.first_name..'*'
end
else 
data[tostring(target)]["settings"]["lock_link"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "🔓*Link* _Posting Has Been Unlocked_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
else
return "لقد تم فتح قفل الروابط 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end



---------------Lock fuck-------------------
local function lock_fuck(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator* \n `MSG BY:` *"..msg.from.first_name..'*'
else
 return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end

local lock_fuck = data[tostring(target)]["settings"]["lock_fuck"] 
if lock_fuck == "yes" then
if not lang then
 return "🔐*Fosh* _Posting Is Already Locked_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
 return "قفل الكلمات البذيئه مقفل مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else
data[tostring(target)]["settings"]["lock_fuck"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "🔐*Fosh* _ Has Been Locked_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
else
 return "لقد تم قفل الكلمات السيئه 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

local function unlock_fuck(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end 

local lock_fuck = data[tostring(target)]["settings"]["lock_fuck"]
 if lock_fuck == "no" then
if not lang then
return "🔓*Fosh* _Is Not Locked_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
return "قفل الكلمات البذيئه مفتوح مسبقا ♻\n `MSG BY:` *"..msg.from.first_name..'*'
end
else 
data[tostring(target)]["settings"]["lock_fuck"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "🔓*Fosh* _Has Been Unlocked_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
else
return "لقد تم فتح الكلمات السيئه ⚠ \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

---------------Lock Tag-------------------
local function lock_tag(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"] 
if lock_tag == "yes" then
if not lang then
 return "🔐*Tag* _Posting Is Already Locked_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
 return "التاگ مقفل مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else
 data[tostring(target)]["settings"]["lock_tag"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "🔐*Tag* _Posting Has Been Locked_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
else
 return "تم قفل التاگ 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

local function unlock_tag(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
 return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end 
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"]
 if lock_tag == "no" then
if not lang then
return "🔓*Tag* _Posting Is Not Locked_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
return "قفل التاك مفتوح مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else 
data[tostring(target)]["settings"]["lock_tag"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "🔓*Tag* _Posting Has Been Unlocked_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
else
return "لقد تم فتح التاگ 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

---------------Lock Mention-------------------
local function lock_mention(msg, data, target)
 local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end

local lock_mention = data[tostring(target)]["settings"]["lock_mention"] 
if lock_mention == "yes" then
if not lang then
 return "🔐*Mention* _Posting Is Already Locked_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
 return " استدعاء الاشخاص مقفل مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else
 data[tostring(target)]["settings"]["lock_mention"] = "yes"
save_data(_config.moderation.data, data)
if not lang then 
 return "🔐*Mention* _Posting Has Been Locked_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
else 
 return "تم قفل استدعاء الاشخاص 📛 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

local function unlock_mention(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end 

local lock_mention = data[tostring(target)]["settings"]["lock_mention"]
 if lock_mention == "no" then
if not lang then
return "🔓*Mention* _Posting Is Not Locked_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
return "استدعاء الاشخاص مفتوح مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else 
data[tostring(target)]["settings"]["lock_mention"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "🔓*Mention* _Posting Has Been Unlocked_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
else
return "لقد تم فتح استدعاء الشخاص ⚠ \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

---------------Lock Arabic--------------
local function lock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end

local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"] 
if lock_arabic == "yes" then
if not lang then
 return "🔐*Arabic/Persian* _Posting Is Already Locked_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
 return " منع الكتابه باللغه العربيه مفعل مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else
data[tostring(target)]["settings"]["lock_arabic"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "🔐*Arabic/Persian* _Posting Has Been Locked_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
else
 return "لقد تم قفل الكتابه بالغه العربيه 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

local function unlock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end 

local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"]
 if lock_arabic == "no" then
if not lang then
return "🔓*Arabic/Persian* _Posting Is Not Locked_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
return "الكتابه باللغه العربيه مفتوح مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else 
data[tostring(target)]["settings"]["lock_arabic"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "🔓*Arabic/Persian* _Posting Has Been Unlocked_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
else
return "لقد تم فتح الكتابه باللغه العربيه ⚠ \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

---------------Lock Edit-------------------
local function lock_edit(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end

local lock_edit = data[tostring(target)]["settings"]["lock_edit"] 
if lock_edit == "yes" then
if not lang then
 return "🔐*Editing* _Is Already Locked_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
 return " التعديل *مقفل* مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else
 data[tostring(target)]["settings"]["lock_edit"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "🔐*Editing* _Has Been Locked_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
else
 return "لقد تم *قفل* التعديل 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

local function unlock_edit(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end 

local lock_edit = data[tostring(target)]["settings"]["lock_edit"]
 if lock_edit == "no" then
if not lang then
return "🔓*Editing* _Is Not Locked_ \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
return "التعديل مفتوح مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else 
data[tostring(target)]["settings"]["lock_edit"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "🔓*Editing* _Has Been Unlocked_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
else
return "لقد تم فتح التعديل ⚠ \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

---------------Lock spam-------------------
local function lock_spam(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end

local lock_spam = data[tostring(target)]["settings"]["lock_spam"] 
if lock_spam == "yes" then
if not lang then
 return "🔐*Spam* _Is Already Locked_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
 return "قفل السبام مفعل مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else
 data[tostring(target)]["settings"]["lock_spam"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "🔐*Spam* _Has Been Locked_ \n `MSG BY:` *"..msg.from.first_name..'*'
else
 return "لقد تم قفل السبام 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

local function unlock_spam(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end 

local lock_spam = data[tostring(target)]["settings"]["lock_spam"]
 if lock_spam == "no" then
if not lang then
return "🔓*Spam* _Posting Is Not Locked_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
 return "قفل السبام غير مفعل مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else 
data[tostring(target)]["settings"]["lock_spam"] = "no" save_data(_config.moderation.data, data)
if not lang then 
return "🔓*Spam* _Posting Has Been Unlocked_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
else
 return "لقد تم فتح قفل السبام 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

---------------Lock Flood-------------------
local function lock_flood(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end

local lock_flood = data[tostring(target)]["settings"]["flood"] 
if lock_flood == "yes" then
if not lang then
 return "🔐*Flooding* _Is Already Locked_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
 return "منع التكرار مقفول مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else
 data[tostring(target)]["settings"]["flood"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "🔐*Flooding* _Has Been Locked_🔐"
else
 return "تم قفل التكرار 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

local function unlock_flood(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end 

local lock_flood = data[tostring(target)]["settings"]["flood"]
 if lock_flood == "no" then
if not lang then
return "🔓*Flooding* _Is Not Locked_🔓 \n `MSG BY:` *"..msg.from.first_name..'*' 
elseif lang then
return "التكرار مفتوح مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else 
data[tostring(target)]["settings"]["flood"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "🔓*Flooding* _Has Been Unlocked_🔓" 
else
return "لقد تم فتح التكرار ⚠ \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

---------------Lock Bots-------------------
local function lock_bots(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"] 
if lock_bots == "yes" then
if not lang then
 return "🔐*Bots* _Protection Is Already Enabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
 return "قفل البوتات مفعل مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else
 data[tostring(target)]["settings"]["lock_bots"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "🔐*Bots* _Protection Has Been Enabled_🔐"
else
 return "لقد تم قفل البوتات 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

local function unlock_bots(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end 
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"]
 if lock_bots == "no" then
if not lang then
return "🔓*Bots* _Protection Is Not Enabled_ \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
return "اضافه البوتات مفتوحه مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else 
data[tostring(target)]["settings"]["lock_bots"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "🔓*Bots* _Protection Has Been Disabled_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
else
return "لقد تم فتح اضافة البوتات ⚠ \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

---------------Lock Markdown-------------------
local function lock_markdown(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"] 
if lock_markdown == "yes" then
if not lang then 
 return "🔐*Markdown* _Posting Is Already Locked_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
 return "قفل الماركداون مفعل مسبقا ♻\n `MSG BY:` *"..msg.from.first_name..'*'
end
else
 data[tostring(target)]["settings"]["lock_markdown"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "🔐*Markdown* _Posting Has Been Locked_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
else
 return "لقد تم قفل الماركداون 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

local function unlock_markdown(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end 
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"]
 if lock_markdown == "no" then
if not lang then
return "🔓*Markdown* _Posting Is Not Locked_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
return " الناركداون مفتوح مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else 
data[tostring(target)]["settings"]["lock_markdown"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "🔓*Markdown* _Posting Has Been Unlocked_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
else
return "لقد تم فتح الماركداون ⚠ \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

---------------Lock Webpage-------------------
local function lock_webpage(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"] 
if lock_webpage == "yes" then
if not lang then
 return "🔐*Webpage* _Is Already Locked_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
 return " صفحات الويب مقفوله مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else
 data[tostring(target)]["settings"]["lock_webpage"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "🔐*Webpage* _Has Been Locked_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
else
 return "لقد تم قفل صفحات الويب 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

local function unlock_webpage(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end 
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"]
 if lock_webpage == "no" then
if not lang then
return "🔓*Webpage* _Is Not Locked_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
return "صفحات الويب مفتوحه مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else 
data[tostring(target)]["settings"]["lock_webpage"] = "no"
save_data(_config.moderation.data, data) 
if not lang then
return "🔓*Webpage* _Has Been Unlocked_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
else
return "لقد تم فتح صفحات الويب ⚠ \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

function group_settings(msg, target) 	
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 	return "_You're Not_ *Moderator*"
else
  return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end
local data = load_data(_config.moderation.data)
local target = msg.chat_id_ 
if data[tostring(target)] then 	
if data[tostring(target)]["settings"]["num_msg_max"] then 	
NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['num_msg_max'])
	print('custom'..NUM_MSG_MAX) 	
else 	
NUM_MSG_MAX = 5
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_link"] then			
data[tostring(target)]["settings"]["lock_link"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_tag"] then			
data[tostring(target)]["settings"]["lock_tag"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_fuck"] then			
data[tostring(target)]["settings"]["lock_fuck"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_mention"] then			
data[tostring(target)]["settings"]["lock_mention"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_arabic"] then			
data[tostring(target)]["settings"]["lock_arabic"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_edit"] then			
data[tostring(target)]["settings"]["lock_edit"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_spam"] then			
data[tostring(target)]["settings"]["lock_spam"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_flood"] then			
data[tostring(target)]["settings"]["lock_flood"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_bots"] then			
data[tostring(target)]["settings"]["lock_bots"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_markdown"] then			
data[tostring(target)]["settings"]["lock_markdown"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_webpage"] then			
data[tostring(target)]["settings"]["lock_webpage"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["welcome"] then			
data[tostring(target)]["settings"]["welcome"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_all"] then			
data[tostring(target)]["settings"]["lock_all"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_gif"] then			
data[tostring(target)]["settings"]["lock_gif"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_text"] then			
data[tostring(target)]["settings"]["lock_text"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_photo"] then			
data[tostring(target)]["settings"]["lock_photo"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_video"] then			
data[tostring(target)]["settings"]["lock_video"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_audio"] then			
data[tostring(target)]["settings"]["lock_audio"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_voice"] then			
data[tostring(target)]["settings"]["lock_voice"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_sticker"] then			
data[tostring(target)]["settings"]["lock_sticker"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_contact"] then			
data[tostring(target)]["settings"]["lock_contact"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_forward"] then			
data[tostring(target)]["settings"]["lock_forward"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_location"] then			
data[tostring(target)]["settings"]["lock_location"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_document"] then			
data[tostring(target)]["settings"]["lock_document"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_tgservice"] then			
data[tostring(target)]["settings"]["lock_tgservice"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_inline"] then			
data[tostring(target)]["settings"]["lock_inline"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_game"] then			
data[tostring(target)]["settings"]["lock_game"] = "no"		
end
end


local expiretime = redis:hget('expiretime', msg.chat_id_)
    local expire = ''
  if not expiretime then
  expire = expire..'Unlimited'
  else
   local now = tonumber(os.time())
   expire =  expire..math.floor((tonumber(expiretime) - tonumber(now)) / 86400) + 1
 end
	
	
	
if not lang then
local settings = data[tostring(target)]["settings"] 
 text = "⚙️*soperGroup Settings*⚙️\n*__________________*\n● 》_Lock edit ➢_ *"..settings.lock_edit.."*\n● 》_Lock links ➢_ *"..settings.lock_link.."*\n● 》_Lock fuck ➢_ *"..settings.lock_fuck.."*\n● 》_Lock tags ➢_ *"..settings.lock_tag.."*\n● 》_Lock Persian* ➢_ *"..settings.lock_arabic.."*\n● 》_Lock flood ➢_ *"..settings.flood.."*\n● 》_Lock spam ➢_ *"..settings.lock_spam.."*\n● 》_Lock mention ➢_ *"..settings.lock_mention.."*\n● 》_Lock webpage ➢_ *"..settings.lock_webpage.."*\n● 》_welcome ➢_ *"..settings.welcome.."*\n● 》_Lock markdown ➢_ *"..settings.lock_markdown.."*\n● 》_Lock Bots ➢_ *"..settings.lock_bots.."*\n● 》_Lock gif ➢_ *"..settings.lock_gif.."*\n● 》_Lock text ➢_ *"..settings.lock_text.."*\n● 》_Lock inline ➢_ *"..settings.lock_inline.."*\n● 》_Lock game ➢_ *"..settings.lock_game.."*\n● 》_Lock photo ➢_ *"..settings.lock_photo.."*\n● 》_Lock video ➢_ *"..settings.lock_video.."*\n● 》_Lock audio ➢_ *"..settings.lock_audio.."*\n● 》_Lock voice ➢_ *"..settings.lock_voice.."*\n● 》_Lock sticker ➢_ *"..settings.lock_sticker.."*\n● 》_Lock contact ➢_ *"..settings.lock_contact.."*\n● 》_Lock forward ➢_ *"..settings.lock_forward.."*\n● 》_Lock location ➢_ *"..settings.lock_location.."*\n● 》_Lock document ➢_ *"..settings.lock_document.."*\n● 》_Lock TgService ➢_ *"..settings.lock_tgservice.."*\n● 》_Lock all : _ *"..settings.lock_all.."*\n*__________________*\n● 》_Flood sensitivity ➢_ *"..NUM_MSG_MAX.."*\n● 》_Expire time ➢_ *"..expire.."*\n*__________________*\n Enable✓ ➰ Disable✘ \n*__________________*\n support: @lock_at_me_now or @TES_56 \n*__________________*\n*Language* : *EN*"
else
local settings = data[tostring(target)]["settings"] 
 text = "⚙️*Group Settings*⚙️\n*__________________*\n● 》_Lock edit ➢_ *"..settings.lock_edit.."*\n● 》_Lock links ➢_ *"..settings.lock_link.."*\n● 》_Lock fuck ➢_ *"..settings.lock_fuck.."*\n● 》_Lock tags ➢_ *"..settings.lock_tag.."*\n● 》_Lock Persian* ➢_ *"..settings.lock_arabic.."*\n● 》_Lock flood ➢_ *"..settings.flood.."*\n● 》_Lock spam ➢_ *"..settings.lock_spam.."*\n● 》_Lock mention ➢_ *"..settings.lock_mention.."*\n● 》_Lock webpage ➢_ *"..settings.lock_webpage.."*\n● 》_welcome ➢_ *"..settings.welcome.."*\n● 》_Lock markdown ➢_ *"..settings.lock_markdown.."*\n● 》_Lock Bots ➢_ *"..settings.lock_bots.."*\n● 》_Lock gif ➢_ *"..settings.lock_gif.."*\n● 》_Lock text ➢_ *"..settings.lock_text.."*\n● 》_Lock inline ➢_ *"..settings.lock_inline.."*\n● 》_Lock game ➢_ *"..settings.lock_game.."*\n● 》_Lock photo ➢_ *"..settings.lock_photo.."*\n● 》_Lock video ➢_ *"..settings.lock_video.."*\n● 》_Lock audio ➢_ *"..settings.lock_audio.."*\n● 》_Lock voice ➢_ *"..settings.lock_voice.."*\n● 》_Lock sticker ➢_ *"..settings.lock_sticker.."*\n● 》_Lock contact ➢_ *"..settings.lock_contact.."*\n● 》_Lock forward ➢_ *"..settings.lock_forward.."*\n● 》_Lock location ➢_ *"..settings.lock_location.."*\n● 》_Lock document ➢_ *"..settings.lock_document.."*\n● 》_Lock TgService ➢_ *"..settings.lock_tgservice.."*\n● 》_Lock all : _ *"..settings.lock_all.."*\n*__________________*\n● 》_Flood sensitivity ➢_ *"..NUM_MSG_MAX.."*\n● 》_welcome msg ➢_ *"..settings.welcome.."*\n● 》_Expire time ➢_ *"..expire.."*\n*__________________*\n Enable✓ ➰ Disable✘ \n*__________________*\n support: @lock_at_me_now or @THS_56 \n*__________________*\n*Language* : *EN*"
end
if not lang then
text = string.gsub(text, "yes", "✓")
 text =  string.gsub(text, "no", "✘")
 else
 text = string.gsub(text, "yes", "✓")
 text =  string.gsub(text, "no", "✘")
 end
return text
end
--------locks---------
--------lock all------------------------
local function lock_all(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then 
if not lang then
return "_You're Not_ *Moderator*" 
else
return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end

local lock_all = data[tostring(target)]["settings"]["lock_all"] 
if lock_all == "yes" then 
if not lang then
return "🔐*lock All* _Is Already Enabled_🔐" 
elseif lang then
return "قفل كل شيئ فعال مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else 
data[tostring(target)]["settings"]["lock_all"] = "yes"
 save_data(_config.moderation.data, data) 
if not lang then
return "🔐*lock All* _Has Been Enabled_ \n `MSG BY:` *"..msg.from.first_name..'*'
else
return "لقد تم قفل كل شيئ 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

local function unlock_all(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then 
if not lang then
return "_You're Not_ *Moderator*" 
else
return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end

local lock_all = data[tostring(target)]["settings"]["lock_all"] 
if lock_all == "no" then 
if not lang then
return "🔓*lock All* _Is Already Disabled_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
return "ان كل شيئ مفتوح مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else 
data[tostring(target)]["settings"]["lock_all"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "🔓*lock All* _Has Been Disabled_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
else
return "تم فتح كل شيئ ⚠ \n `MSG BY:` *"..msg.from.first_name..'*'
end 
end
end

---------------lock Gif-------------------
local function lock_gif(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end

local lock_gif = data[tostring(target)]["settings"]["lock_gif"] 
if lock_gif == "yes" then
if not lang then
 return "🔐*lock Gif* _Is Already Enabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
 return "الصور المتحركة مقفوله مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else
 data[tostring(target)]["settings"]["lock_gif"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then 
 return "🔓*lock Gif* _Has Been Enabled_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
else
 return "لقد تم قفل الصور المتحركه 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

local function unlock_gif(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end 

local lock_gif = data[tostring(target)]["settings"]["lock_gif"]
 if lock_gif == "no" then
if not lang then
return "🔐*lock Gif* _Is Already Disabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
return "الصور المتحركه مفتوحه مسبقا 📛 \n `MSG BY:` *"..msg.from.first_name..'*'
end
else 
data[tostring(target)]["settings"]["lock_gif"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "🔐*lock Gif* _Has Been Disabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
else
return "لقد تم فتح الصور المتحركه ⚠ \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end
---------------lock Game-------------------
local function lock_game(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end

local lock_game = data[tostring(target)]["settings"]["lock_game"] 
if lock_game == "yes" then
if not lang then
 return "🔐*lock Game* _Is Already Enabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
 return "قفل الالعاب مفعل مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else
 data[tostring(target)]["settings"]["lock_game"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "🔐*lock Game* _Has Been Enabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
else
 return "لقد تم تفعيل قفل الالعاب 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

local function unlock_game(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end 
end

local lock_game = data[tostring(target)]["settings"]["lock_game"]
 if lock_game == "no" then
if not lang then
return "🔓*lock Game* _Is Already Disabled_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
return "الالعاب مفتوحه مسبقا 📛 \n `MSG BY:` *"..msg.from.first_name..'*'
end
else 
data[tostring(target)]["settings"]["lock_game"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "🔓*lock Game* _Has Been Disabled_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
else
return "لقد تم فتح الالعاب ⚠ \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end
---------------lock Inline-------------------
local function lock_inline(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end

local lock_inline = data[tostring(target)]["settings"]["lock_inline"] 
if lock_inline == "yes" then
if not lang then
 return "🔐*lock Inline* _Is Already Enabled_🔐"
elseif lang then
 return "قفل كيبورد الـ انلاين مفعل مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else
 data[tostring(target)]["settings"]["lock_inline"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "🔐*lock Inline* _Has Been Enabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
else
 return "لقد تم قفل كيبورد الـ انلاين 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

local function unlock_inline(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end 

local lock_inline = data[tostring(target)]["settings"]["lock_inline"]
 if lock_inline == "no" then
if not lang then
return "🔓*lock Inline* _Is Already Disabled_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
return "كيبورد الـ انلاين مفتوح مسبقا 📛 \n `MSG BY:` *"..msg.from.first_name..'*'
end
else 
data[tostring(target)]["settings"]["lock_inline"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "🔓*lock Inline* _Has Been Disabled_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
else
return "لقد تم فتح كيبورد الـ انلاين ⚠ \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end
---------------lock Text-------------------
local function lock_text(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end

local lock_text = data[tostring(target)]["settings"]["lock_text"] 
if lock_text == "yes" then
if not lang then
 return "🔐*lock Text* _Is Already Enabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
 return "قفل النص مفعل مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else
 data[tostring(target)]["settings"]["lock_text"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "🔐*lock Text* _Has Been Enabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
else
 return "لقد تم قفل النص 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

local function unlock_text(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end 
end

local lock_text = data[tostring(target)]["settings"]["lock_text"]
 if lock_text == "no" then
if not lang then
return "🔓*lock Text* _Is Already Disabled_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
return "بالفعل النص مفتوح مسبقا 📛 \n `MSG BY:` *"..msg.from.first_name..'*'
end
else 
data[tostring(target)]["settings"]["lock_text"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "🔓*lock Text* _Has Been Disabled_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
else
return "لقد تم فتح النص ⚠ \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end
---------------lock photo-------------------
local function lock_photo(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "🔐_You're Not_ *Moderator*🔐"
else
 return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end

local lock_photo = data[tostring(target)]["settings"]["lock_photo"] 
if lock_photo == "yes" then
if not lang then
 return "🔐*lock Photo* _Is Already Enabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
 return "قفل الصور مفعل مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else
 data[tostring(target)]["settings"]["lock_photo"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "🔐*lock Photo* _Has Been Enabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
else
 return "لقد تم قفل الصور 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

local function unlock_photo(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end
 
local lock_photo = data[tostring(target)]["settings"]["lock_photo"]
 if lock_photo == "no" then
if not lang then
return "🔓*lock Photo* _Is Already Disabled_🔓" 
elseif lang then
return "الصور مفتوحه مسبقا 📛 \n `MSG BY:` *"..msg.from.first_name..'*'
end
else 
data[tostring(target)]["settings"]["lock_photo"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "🔓*lock Photo* _Has Been Disabled_🔓" 
else
return "لقد تم فتح الصور ⚠ \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end
---------------lock Video-------------------
local function lock_video(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end

local lock_video = data[tostring(target)]["settings"]["lock_video"] 
if lock_video == "yes" then
if not lang then
 return "🔐*lock Video* _Is Already Enabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
 return "قفل الفيديو مفعل مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else
 data[tostring(target)]["settings"]["lock_video"] = "yes" 
save_data(_config.moderation.data, data)
if not lang then 
 return "🔐*lock Video* _Has Been Enabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
else
 return "لقد تم قفل الفيديو 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

local function unlock_video(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end 

local lock_video = data[tostring(target)]["settings"]["lock_video"]
 if lock_video == "no" then
if not lang then
return "🔓*lock Video* _Is Already Disabled_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
return "الفيديوهات مفتوحه مسبقا 📛 \n `MSG BY:` *"..msg.from.first_name..'*'
end
else 
data[tostring(target)]["settings"]["lock_video"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "🔓*lock Video* _Has Been Disabled_🔓" 
else
return "لقد تم فتح الفيديوهات ⚠ \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end
---------------lock Audio-------------------
local function lock_audio(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end

local lock_audio = data[tostring(target)]["settings"]["lock_audio"] 
if lock_audio == "yes" then
if not lang then
 return "🔐*lock Audio* _Is Already Enabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
 return "قفل الصوتيات مفعل مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else
 data[tostring(target)]["settings"]["lock_audio"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "🔐*lock Audio* _Has Been Enabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
else 
return "لقد تم قفل الصوتيات 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

local function unlock_audio(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end 

local lock_audio = data[tostring(target)]["settings"]["lock_audio"]
 if lock_audio == "no" then
if not lang then
return "🔓*lock Audio* _Is Already Disabled_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
return "الصوتيات مفتوحه مسبقا 📛 \n `MSG BY:` *"..msg.from.first_name..'*'
end
else 
data[tostring(target)]["settings"]["lock_audio"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "🔓*lock Audio* _Has Been Disabled_🔓"
else
return "لقد تم فتح الصوتيات ⚠ \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end
---------------lock Voice-------------------
local function lock_voice(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end

local lock_voice = data[tostring(target)]["settings"]["lock_voice"] 
if lock_voice == "yes" then
if not lang then
 return "🔐*lock Voice* _Is Already Enabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
 return "قفل الصوت مفعل مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else
 data[tostring(target)]["settings"]["lock_voice"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "🔐*lock Voice* _Has Been Enabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
else
 return "لقد تم قفل الصوت 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

local function unlock_voice(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end 

local lock_voice = data[tostring(target)]["settings"]["lock_voice"]
 if lock_voice == "no" then
if not lang then
return "🔓*lock Voice* _Is Already Disabled_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
return "الصوت مفتوح مسبقا 📛 \n `MSG BY:` *"..msg.from.first_name..'*'
end
else 
data[tostring(target)]["settings"]["lock_voice"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "🔓*lock Voice* _Has Been Disabled_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
else
return "لقد تم فتح الصوت ⚠ \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end
---------------lock Sticker-------------------
local function lock_sticker(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end

local lock_sticker = data[tostring(target)]["settings"]["lock_sticker"] 
if lock_sticker == "yes" then
if not lang then
 return "🔐*lock Sticker* _Is Already Enabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
 return "قفل الملصقات مفعل مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else
 data[tostring(target)]["settings"]["lock_sticker"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "🔐*lock Sticker* _Has Been Enabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
else
 return "لقد تم قفل الملصقات 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

local function unlock_sticker(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end 
end

local lock_sticker = data[tostring(target)]["settings"]["lock_sticker"]
 if lock_sticker == "no" then
if not lang then
return "🔓*lock Sticker* _Is Already Disabled_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
return "الملصقات مفتوحه مسبقا 📛 \n `MSG BY:` *"..msg.from.first_name..'*'
end
else 
data[tostring(target)]["settings"]["lock_sticker"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "🔓*lock Sticker* _Has Been Disabled_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
else
return "لقد تم فتح الملصقات ⚠ \n `MSG BY:` *"..msg.from.first_name..'*'
end 
end
end
---------------lock Contact-------------------
local function lock_contact(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end

local lock_contact = data[tostring(target)]["settings"]["lock_contact"] 
if lock_contact == "yes" then
if not lang then
 return "🔐*lock Contact* _Is Already Enabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
 return "قفل جهات الاتصال مفعل مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else
 data[tostring(target)]["settings"]["lock_contact"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "🔐*lock Contact* _Has Been Enabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
else
 return "لقد تم قفل جهات الاتصال 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

local function unlock_contact(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end 

local lock_contact = data[tostring(target)]["settings"]["lock_contact"]
 if lock_contact == "no" then
if not lang then
return "🔓*lock Contact* _Is Already Disabled_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
return "جهات الاتصال مفتوحه مسبقا 📛 \n `MSG BY:` *"..msg.from.first_name..'*'
end
else 
data[tostring(target)]["settings"]["lock_contact"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "🔓*lock Contact* _Has Been Disabled_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
else
return "لقد تم فتح جهات الاتصال ⚠ \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end
---------------lock Forward-------------------
local function lock_forward(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end

local lock_forward = data[tostring(target)]["settings"]["lock_forward"] 
if lock_forward == "yes" then
if not lang then
 return "🔐*lock Forward* _Is Already Enabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
 return "قفل اعاده توجيه الرسائل مفعل مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else
 data[tostring(target)]["settings"]["lock_forward"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "🔐*lock Forward* _Has Been Enabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
else
 return "لقد تم قفل اعاده توجيه الرسائل 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

local function unlock_forward(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end 

local lock_forward = data[tostring(target)]["settings"]["lock_forward"]
 if lock_forward == "no" then
if not lang then
return "🔓*lock Forward* _Is Already Disabled_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
return "توجيه الرسائل مفتوح مسبقا 📛 \n `MSG BY:` *"..msg.from.first_name..'*'
end 
else 
data[tostring(target)]["settings"]["lock_forward"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "🔓*lock Forward* _Has Been Disabled_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
else
return "لقد تم فتح اعاده توجيه الرسائل ⚠ \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end
---------------lock Location-------------------
local function lock_location(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end

local lock_location = data[tostring(target)]["settings"]["lock_location"] 
if lock_location == "yes" then
if not lang then
 return "🔐*lock Location* _Is Already Enabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
 return "قفل الموقع مفعل مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else
 data[tostring(target)]["settings"]["lock_location"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "🔐*lock Location* _Has Been Enabled_ \n `MSG BY:` *"..msg.from.first_name..'*'
else
 return "لقد تم قفل الموقع 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

local function unlock_location(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end 

local lock_location = data[tostring(target)]["settings"]["lock_location"]
 if lock_location == "no" then
if not lang then
return "🔓*lock Location* _Is Already Disabled_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
return "الموقع مفتوح مسبقا 📛\n `MSG BY:` *"..msg.from.first_name..'*'
end
else 
data[tostring(target)]["settings"]["lock_location"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "🔓*lock Location* _Has Been Disabled_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
else
return "لقد تم فتح الموقع \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end
---------------lock Document-------------------
local function lock_document(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end

local lock_document = data[tostring(target)]["settings"]["lock_document"] 
if lock_document == "yes" then
if not lang then
 return "🔐*lock Document* _Is Already Enabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
 return "قفل الملفات مفعل مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else
 data[tostring(target)]["settings"]["lock_document"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "🔐*lock Document* _Has Been Enabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
else
 return "لقد تم قفل الملفات 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

local function unlock_document(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end 

local lock_document = data[tostring(target)]["settings"]["lock_document"]
 if lock_document == "no" then
if not lang then
return "🔓*lock Document* _Is Already Disabled_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
return "الملفات مفتوحه مسبقا 📛 \n `MSG BY:` *"..msg.from.first_name..'*'
end
else 
data[tostring(target)]["settings"]["lock_document"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "🔓*lock Document* _Has Been Disabled_🔓 \n `MSG BY:` *"..msg.from.first_name..'*'
else
return "لقد تم فتح الملفات ⚠ \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end
---------------lock TgService-------------------
local function lock_tgservice(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end
end

local lock_tgservice = data[tostring(target)]["settings"]["lock_tgservice"] 
if lock_tgservice == "yes" then
if not lang then
 return "🔐*lock TgService* _Is Already Enabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
 return "خدمه tg مقفول مسبقا ♻ \n `MSG BY:` *"..msg.from.first_name..'*'
end
else
 data[tostring(target)]["settings"]["lock_tgservice"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "🔐*lock TgService* _Has Been Enabled_🔐 \n `MSG BY:` *"..msg.from.first_name..'*'
else
return " لقد تم قفل خدمه tg 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
end

local function unlock_tgservice(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مشرف ❌ \n 🔖`msg By:️`"..msg.from.first_name
end 
end

local lock_tgservice = data[tostring(target)]["settings"]["lock_tgservice"]
 if lock_tgservice == "no" then
if not lang then
return "🔓*lock TgService* _Is Already Disabled_🔓\n `MSG BY:` *"..msg.from.first_name..'*'
elseif lang then
return "خدمه tg مفتوحه مسبقا 📛 \n `MSG BY:` *"..msg.from.first_name..'*'
end 
else 
data[tostring(target)]["settings"]["lock_tgservice"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "🔓*lock TgService* _Has Been Disabled_🔓"
else
return "لقد تم فتح خدمه tg ⚠\n `MSG BY:` *"..msg.from.first_name..'*'
end 
end
end


local function run(msg, matches)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
   local chat = msg.chat_id_
   local user = msg.sender_user_id_
if matches[1] == "id" then
if not matches[2] and tonumber(msg.reply_to_message_id_) == 0 then
   if not lang then
return "*Chat ID :* _"..chat.."_\n*User ID :* _"..user.."_"
   else
return "*ايدي المحادثه :* _"..chat.."_\n*ايدي العضو :* _"..user.."_"
   end
end
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="id"})
  end
if matches[2] and tonumber(msg.reply_to_message_id_) == 0 then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="id"})
      end
   end
if matches[1] == "pin" and is_owner(msg) then
tdcli.pinChannelMessage(msg.chat_id_, msg.reply_to_message_id_, 1)
if not lang then
return "*Message Has Been Pinned* \n `MSG BY:` *"..msg.from.first_name..'*'
else
return "لقد تم تثبيت الرساله بنجاح 🔖\n `MSG BY:` *"..msg.from.first_name..'*'
end
end
if matches[1] == 'unpin' and is_mod(msg) then
tdcli.unpinChannelMessage(msg.chat_id_)
if not lang then
return "*Pin message has been unpinned* \n `MSG BY:` *"..msg.from.first_name..'*'
else
return "لقد تم ازاله تثبيت الرساله بنحاح ➿ \n `MSG BY:` *"..msg.from.first_name..'*'
end
end
if matches[1] == "add" then
return modadd(msg)
end
if matches[1] == "rem" then
return modrem(msg)
end
if matches[1] == "setowner" and is_admin(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="setowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.chat_id_,user_id=matches[2],cmd="setowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="setowner"})
      end
   end
if matches[1] == "remowner" and is_admin(msg) then
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.chat_id_,user_id=matches[2],cmd="setowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="setowner"})
      end
   end
if matches[1] == "remowner" and is_admin(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="remowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.chat_id_,user_id=matches[2],cmd="remowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="remowner"})
      end
   end
if matches[1] == "promote" and is_owner(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="promote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.chat_id_,user_id=matches[2],cmd="promote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="promote"})
      end
   end
if matches[1] == "demote" and is_owner(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
 tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="demote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.chat_id_,user_id=matches[2],cmd="demote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="demote"})
      end
   end

if matches[1] == "lock" and is_mod(msg) then
local target = msg.chat_id_
if matches[2] == "link" then
return lock_link(msg, data, target)
end
if matches[2] == "fuck" then
return lock_fuck(msg, data, target)
end
if matches[2] == "tag" then
return lock_tag(msg, data, target)
end
if matches[2] == "mention" then
return lock_mention(msg, data, target)
end
if matches[2] == "arabic" then
return lock_arabic(msg, data, target)
end
if matches[2] == "edit" then
return lock_edit(msg, data, target)
end
if matches[2] == "spam" then
return lock_spam(msg, data, target)
end
if matches[2] == "flood" then
return lock_flood(msg, data, target)
end
if matches[2] == "bots" then
return lock_bots(msg, data, target)
end
if matches[2] == "markdown" then
return lock_markdown(msg, data, target)
end
if matches[2] == "webpage" then
return lock_webpage(msg, data, target)
end
end

if matches[1] == "unlock" and is_mod(msg) then
local target = msg.chat_id_
if matches[2] == "link" then
return unlock_link(msg, data, target)
end
if matches[2] == "fuck" then
return unlock_fuck(msg, data, target)
end
if matches[2] == "tag" then
return unlock_tag(msg, data, target)
end
if matches[2] == "mention" then
return unlock_mention(msg, data, target)
end
if matches[2] == "arabic" then
return unlock_arabic(msg, data, target)
end
if matches[2] == "edit" then
return unlock_edit(msg, data, target)
end
if matches[2] == "spam" then
return unlock_spam(msg, data, target)
end
if matches[2] == "flood" then
return unlock_flood(msg, data, target)
end
if matches[2] == "bots" then
return unlock_bots(msg, data, target)
end
if matches[2] == "markdown" then
return unlock_markdown(msg, data, target)
end
if matches[2] == "webpage" then
return unlock_webpage(msg, data, target)
end
end
if matches[1] == "lock" and is_mod(msg) then
local target = msg.chat_id_
if matches[2] == "all" then
return lock_all(msg, data, target)
end
if matches[2] == "gif" then
return lock_gif(msg, data, target)
end
if matches[2] == "text" then
return lock_text(msg ,data, target)
end
if matches[2] == "photo" then
return lock_photo(msg ,data, target)
end
if matches[2] == "video" then
return lock_video(msg ,data, target)
end
if matches[2] == "audio" then
return lock_audio(msg ,data, target)
end
if matches[2] == "voice" then
return lock_voice(msg ,data, target)
end
if matches[2] == "sticker" then
return lock_sticker(msg ,data, target)
end
if matches[2] == "contact" then
return lock_contact(msg ,data, target)
end
if matches[2] == "forward" then
return lock_forward(msg ,data, target)
end
if matches[2] == "location" then
return lock_location(msg ,data, target)
end
if matches[2] == "document" then
return lock_document(msg ,data, target)
end
if matches[2] == "tgservice" then
return lock_tgservice(msg ,data, target)
end
if matches[2] == "inline" then
return lock_inline(msg ,data, target)
end
if matches[2] == "game" then
return lock_game(msg ,data, target)
end
end

if matches[1] == "unlock" and is_mod(msg) then
local target = msg.chat_id_
if matches[2] == "all" then
return unlock_all(msg, data, target)
end
if matches[2] == "gif" then
return unlock_gif(msg, data, target)
end
if matches[2] == "text" then
return unlock_text(msg, data, target)
end
if matches[2] == "photo" then
return unlock_photo(msg ,data, target)
end
if matches[2] == "video" then
return unlock_video(msg ,data, target)
end
if matches[2] == "audio" then
return unlock_audio(msg ,data, target)
end
if matches[2] == "voice" then
return unlock_voice(msg ,data, target)
end
if matches[2] == "sticker" then
return unlock_sticker(msg ,data, target)
end
if matches[2] == "contact" then
return unlock_contact(msg ,data, target)
end
if matches[2] == "forward" then
return unlock_forward(msg ,data, target)
end
if matches[2] == "location" then
return unlock_location(msg ,data, target)
end
if matches[2] == "document" then
return unlock_document(msg ,data, target)
end
if matches[2] == "tgservice" then
return unlock_tgservice(msg ,data, target)
end
if matches[2] == "inline" then
return unlock_inline(msg ,data, target)
end
if matches[2] == "game" then
return unlock_game(msg ,data, target)
end
end
if matches[1] == "gpinfo" and is_mod(msg) and gp_type(msg.chat_id_) == "channel" then
local function group_info(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if not lang then
ginfo = "*📢Group Info :*📢\n👲_Admin Count :_ *"..data.administrator_count_.."*\n👥_Member Count :_ *"..data.member_count_.."*\n👿_Kicked Count :_ *"..data.kicked_count_.."*\n🆔_Group ID :_ *"..data.channel_.id_.."*"
print(serpent.block(data))
elseif lang then
ginfo = "📢*معلومات المجموعة *📢\n👲_عدد المشرفين :_ *"..data.administrator_count_.."*\n👥_عدد الاعضاء :_ *"..data.member_count_.."*\n👿_عدد الاعضاء المطرودين :_ *"..data.kicked_count_.."*\n🆔_ايدي المجموعة :_ *"..data.channel_.id_.."*"
print(serpent.block(data))
end
        tdcli.sendMessage(arg.chat_id, arg.msg_id, 1, ginfo, 1, 'md')
end
 tdcli.getChannelFull(msg.chat_id_, group_info, {chat_id=msg.chat_id_,msg_id=msg.id_})
end
		if matches[1] == 'setlink' and is_owner(msg) then
			data[tostring(chat)]['settings']['linkgp'] = 'waiting'
			save_data(_config.moderation.data, data)
      if not lang then
			return '_Please send the new group_ *link* _now_'
    else 
         return 'الرجاء ارسل الي الرابط الان \n⚙ *group name:*'..msg.to.title
       end
		end

		if msg.content_.text_ then
   local is_link = msg.content_.text_:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.content_.text_:match("^([https?://w]*.?t.me/joinchat/%S+)$")
			if is_link and data[tostring(chat)]['settings']['linkgp'] == 'waiting' and is_owner(msg) then
				data[tostring(chat)]['settings']['linkgp'] = msg.content_.text_
				save_data(_config.moderation.data, data)
            if not lang then
				return "*Newlink* _has been set_"
           else
           return "لقد تم تعيين رابط جديد \n⚙ *group name:*"..msg.to.title
		 	end
       end
		end
    if matches[1] == 'link' and is_mod(msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "_First set a link for group with using_ /setlink"
     else
        return "يمكنك ان تصنع رابط جديد بالمجموعه الخاصه بك الان عبر ارسال امر  /setlink \n⚙ *group name:*"..msg.to.title
      end
      end
     if not lang then
       text = "<b>Group Link :</b>\n"..linkgp
     else
      text = "<em> رابط المجموعه :</em>\n"..linkgp
         end
        return tdcli.sendMessage(chat, msg.id_, 1, text, 1, 'html')
     end
  if matches[1] == "setrules" and matches[2] and is_mod(msg) then
    data[tostring(chat)]['rules'] = matches[2]
	  save_data(_config.moderation.data, data)
     if not lang then
    return "*Group rules* _has been set_"
   else 
  return "لقد تم وضع قوانين📝 \n⚙ *group name:*"..msg.to.title
   end
  end
  if matches[1] == "rules" then
 if not data[tostring(chat)]['rules'] then
   if not lang then
     rules = "`Group name`"..msg.to.title.."\n  "
    elseif lang then
       rules = "`Group name`"..msg.to.title.."\n  "
 end
        else
     rules = "*Group Rules :*\n"..data[tostring(chat)]['rules']
      end
    return rules
  end
if matches[1] == "res" and matches[2] and is_mod(msg) then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="res"})
  end
if matches[1] == "whois" and matches[2] and is_mod(msg) then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.chat_id_,user_id=matches[2],cmd="whois"})
  end
  if matches[1] == 'setflood' and is_mod(msg) then
			if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 50 then
				return "_Wrong number, range is_ *[1-50]*"
      end
			local flood_max = matches[2]
			data[tostring(chat)]['settings']['num_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
    return "_Group_ *flood* _sensitivity has been set to :_ *[ "..matches[2].." ]*"
       end
		if matches[1]:lower() == 'clean' and is_owner(msg) then
			if matches[2] == 'mods' then
				if next(data[tostring(chat)]['mods']) == nil then
            if not lang then
					return "_No_ *moderators* _in this group_"
             else
                return "لا يوجد مشرفين في هذا المجموعة 📛 \n `MSG BY:` *"..msg.from.first_name..'*'
				end
            end
				for k,v in pairs(data[tostring(chat)]['mods']) do
					data[tostring(chat)]['mods'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            if not lang then
				return "_All_ *moderators* _has been demoted_"
          else
            return "لقد تم طرد كل المشرفين ❌ \n `MSG BY:` *"..msg.from.first_name..'*'
			end
         end
			if matches[2] == 'filterlist' then
				if next(data[tostring(chat)]['filterlist']) == nil then
     if not lang then
					return "*Filtered words list* _is empty_"
         else
					return "_قائمه الكلمات فارغه_ ⚠ \n `MSG BY:` *"..msg.from.first_name..'*'
             end
				end
				for k,v in pairs(data[tostring(chat)]['filterlist']) do
					data[tostring(chat)]['filterlist'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
       if not lang then
				return "*Filtered words list* _has been cleaned_"
           else
				return "_لقد تم ازاله جميع الكلمات_ 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
           end
			end
			if matches[2] == 'rules' then
				if not data[tostring(chat)]['rules'] then
            if not lang then
					return "_No_ *rules* _available_"
             else
               return "لا يوجد قوانين لعرضها ❌ \n `MSG BY:` *"..msg.from.first_name..'*'
             end
				end
					data[tostring(chat)]['rules'] = nil
					save_data(_config.moderation.data, data)
             if not lang then
				return "*Group rules* _has been cleaned_"
          else
            return "لقد تم ازاله القوانين من المجموعه 📛 \n `MSG BY:` *"..msg.from.first_name..'*'
			end
       end
			if matches[2] == 'welcome' then
				if not data[tostring(chat)]['setwelcome'] then
            if not lang then
					return "*Welcome Message not set*"
             else
               return "لم يتم تعيين رساله الترحيب ⚠ \n `MSG BY:` *"..msg.from.first_name..'*'
             end
				end
					data[tostring(chat)]['setwelcome'] = nil
					save_data(_config.moderation.data, data)
             if not lang then
				return "*Welcome message* _has been cleaned_"
          else
            return "لقد ام ازاله رساله الترحيب ❌ \n `MSG BY:` *"..msg.from.first_name..'*'
			end
       end
			if matches[2] == 'about' then
        if gp_type(chat) == "chat" then
				if not data[tostring(chat)]['about'] then
            if not lang then
					return "_No_ *description* _available_"
            else
              return "لا يوجد وصف لعرضه ⚠ \n `MSG BY:` *"..msg.from.first_name..'*'
          end
				end
					data[tostring(chat)]['about'] = nil
					save_data(_config.moderation.data, data)
        elseif gp_type(chat) == "channel" then
   tdcli.changeChannelAbout(chat, "", dl_cb, nil)
             end
             if not lang then
				return "*Group description* _has been cleaned_"
           else
              return " لقد تم ازاله الوصف من المجموعه 📛 \n `MSG BY:` *"..msg.from.first_name..'*'
             end
		   	end
        end
		if matches[1]:lower() == 'clean' and is_admin(msg) then
			if matches[2] == 'owners' then
				if next(data[tostring(chat)]['owners']) == nil then
             if not lang then
					return "_No_ *owners* _in this group_"
            else
                return "لا يوجد مدراء في هذه المجموعه ⚠ \n `MSG BY:` *"..msg.from.first_name..'*'
            end
				end
				for k,v in pairs(data[tostring(chat)]['owners']) do
					data[tostring(chat)]['owners'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            if not lang then
				return "_All_ *owners* _has been demoted_"
           else
            return "لقد تم تخفيض جميع المدراء 🔖 \n `MSG BY:` *"..msg.from.first_name..'*'
          end
			end
     end
if matches[1] == "setname" and matches[2] and is_mod(msg) then
local gp_name = matches[2]
tdcli.changeChatTitle(chat, gp_name, dl_cb, nil)
end
  if matches[1] == "setabout" and matches[2] and is_mod(msg) then
     if gp_type(chat) == "channel" then
   tdcli.changeChannelAbout(chat, matches[2], dl_cb, nil)
    elseif gp_type(chat) == "chat" then
    data[tostring(chat)]['about'] = matches[2]
	  save_data(_config.moderation.data, data)
     end
     if not lang then
    return "*Group description* _has been set_"
    else
     return "لقد تم تعيين وصف للمجموعه 💡 \n `MSG BY:` *"..msg.from.first_name..'*'
      end
  end
  if matches[1] == "about" and gp_type(chat) == "chat" then
 if not data[tostring(chat)]['about'] then
     if not lang then
     about = "_No_ *description* _available_"
      elseif lang then
      about = "لا يوجد وصف لعرضه ⚠ \n `MSG BY:` *"..msg.from.first_name..'*'
       end
        else
     about = "`group name`("..msg.to.title..")\n *Group Description :*\n"..data[tostring(chat)]['about']
      end
    return about
  end
  if matches[1] == 'filter' and is_mod(msg) then
    return filter_word(msg, matches[2])
  end
  if matches[1] == 'unfilter' and is_mod(msg) then
    return unfilter_word(msg, matches[2])
  end
  if matches[1] == 'filterlist' and is_mod(msg) then
    return filter_list(msg)
  end
if matches[1] == "settings" then
return group_settings(msg, target)
end
if matches[1] == "locklist" then
return locks(msg, target)
end
if matches[1] == "modlist" then
return modlist(msg)
end
if matches[1] == "ownerlist" and is_owner(msg) then
return ownerlist(msg)
end

if matches[1] == "setlang" and is_owner(msg) then
   if matches[2] == "en" then
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 redis:del(hash)
return "_Group Language Set To:_ `EN` ⛑ \n `MSG BY:` *"..msg.from.first_name.."*"
  elseif matches[2] == "ar" then
redis:set(hash, true)
return "*تم تعيين اللغه العربيه في هذه المجموعه * ⛑\n `MSG BY:` *"..msg.from.first_name.."*" 
end
end




if matches[1] == "help" and is_mod(msg) then
if not lang then
text = [[

!mod help 
مساعده المشرف
------------------
!lock help1
اوامر قفل 1
------------------
!lock help2
اوامر قفل 2
------------------
!sudo help 
اوامر المطور
------------------
@lock_at_me_now or @THS_56
------------------
]]

elseif lang then
text = [[
!mod help 
مساعده المشرف
------------------
!lock help1
اوامر قفل 1
------------------
!lock help2
اوامر قفل 2
------------------
!sudo help 
اوامر المطور
------------------
@lock_at_me_now or @THS_56
------------------
]]
end
return text
end

if matches[1] == "inline" and is_mod(msg) then
text5 = [[
inline💡
]]
return text5 
end


--------------------- Welcome -----------------------
	if matches[1] == "welcome" and is_mod(msg) then
		if matches[2] == "enable" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "yes" then
       if not lang then
				return "_Group_ *welcome* _is already enabled_"
       elseif lang then
				return "_الترحيب مفعل مسبقا_ ♻"
           end
			else
		data[tostring(chat)]['settings']['welcome'] = "yes"
	    save_data(_config.moderation.data, data)
       if not lang then
				return "_Group_ *welcome* _has been enabled_"
       elseif lang then
				return "_لقد تم تفعيل الترحيب_ 💡"
          end
			end
		end
		
		if matches[2] == "disable" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "no" then
      if not lang then
				return "_Group_ *Welcome* _is already disabled_"
      elseif lang then
				return "_الترحيب معطل مسبقا_ 📛"
         end
			else
		data[tostring(chat)]['settings']['welcome'] = "no"
	    save_data(_config.moderation.data, data)
      if not lang then
				return "_Group_ *welcome* _has been disabled_"
      elseif lang then
				return "_لقد تم تعطيل الترحيب_ ⚠"
          end
			end
		end
	end
	if matches[1] == "setwelcome" and matches[2] and is_mod(msg) then
		data[tostring(chat)]['setwelcome'] = matches[2]
	    save_data(_config.moderation.data, data)
       if not lang then
		return "_Welcome Message Has Been Set To :_\n*"..matches[2].."*\n\n*You can use :*\n_{rules} ➣ Show Group Rules_\n_{name} ➣ New Member First Name_\n_{username} ➣ New Member Username_"
       else
		return "_لقد تم وضع رساله ترحيب للمجموعه :_\n*"..matches[2].."*\n\n*يمكنك استخدام*\n_{rules} ➣ لعرض القوانين_\n_{name} ➣ لعرض اسمك الاول_\n_{username} ➣ لوضع معرف _\n_"
     end
	end
end
-----------------------------------------
local function pre_process(msg)
   local chat = msg.chat_id_
   local user = msg.sender_user_id_
 local data = load_data(_config.moderation.data)
	local function welcome_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
		administration = load_data(_config.moderation.data)
    if administration[arg.chat_id]['setwelcome'] then
     welcome = administration[arg.chat_id]['setwelcome']
      else
     if not lang then
     welcome = "*hi my friend welcome dude*"
    elseif lang then
     welcome = "_اهلا بك يا صديقي_"
        end
     end
 if administration[tostring(arg.chat_id)]['rules'] then
rules = administration[arg.chat_id]['rules']
else
   if not lang then
     rules = "`Group name`"..msg.to.title.."\n  "
    elseif lang then
       rules = "`Group name`"..msg.to.title.."\n  "
 end
end
if data.username_ then
user_name = "@"..check_markdown(data.username_)
else
user_name = ""
end
		local welcome = welcome:gsub("{rules}", rules)
		local welcome = welcome:gsub("{name}", check_markdown(data.first_name_))
		local welcome = welcome:gsub("{username}", user_name)
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, welcome, 0, "md")
	end
	if data[tostring(chat)] and data[tostring(chat)]['settings'] then
	if msg.adduser then
		welcome = data[tostring(msg.chat_id_)]['settings']['welcome']
		if welcome == "yes" then
			tdcli_function ({
	      ID = "GetUser",
      	user_id_ = msg.adduser
    	}, welcome_cb, {chat_id=chat,msg_id=msg.id_})
		else
			return false
		end
	end
	if msg.joinuser then
		welcome = data[tostring(msg.chat_id_)]['settings']['welcome']
		if welcome == "yes" then
			tdcli_function ({
	      ID = "GetUser",
      	user_id_ = msg.joinuser
    	}, welcome_cb, {chat_id=chat,msg_id=msg.id_})
		else
			return false
        end
		end
	end
 end
return {
patterns ={
"^[!/#](inline)$",
"^[!/#](قفل)$",
"^[!/#](قفل)$",
"^[!/#](id)$",
"^[!/#](id) (.*)$",
"^[!/#](pin)$",
"^[!/#](unpin)$",
"^[!/#](gpinfo)$",
"^[!/#](test)$",
"^[!/#](add)$",
"^[!/#](rem)$",
"^[!/#](setowner)$",
"^[!/#](setowner) (.*)$",
"^[!/#](remowner)$",
"^[!/#](remowner) (.*)$",
"^[!/#](promote)$",
"^[!/#](promote) (.*)$",
"^[!/#](demote)$",
"^[!/#](demote) (.*)$",
"^[!/#](modlist)$",
"^[!/#](ownerlist)$",
"^[!/#](lock) (.*)$",
"^[!/#](unlock) (.*)$",
"^[!/#](settings)$",
"^[!/#](locklist)$",
"^[!/#](lock) (.*)$",
"^[!/#](unlock) (.*)$",
"^[!/#](link)$",
"^[!/#](setlink)$",
"^[!/#](rules)$",
"^[!/#](setrules) (.*)$",
"^[!/#](about)$",
"^[!/#](setabout) (.*)$",
"^[!/#](setname) (.*)$",
"^[!/#](clean) (.*)$",
"^[!/#](setflood) (%d+)$",
"^[!/#](res) (.*)$",
"^[!/#](whois) (%d+)$",
"^[!/#](help)$",
"^[!/#](setlang) (.*)$",
"^[#!/](filter) (.*)$",
"^[#!/](unfilter) (.*)$",
"^[#!/](filterlist)$",
"^([https?://w]*.?t.me/joinchat/%S+)$",
"^([https?://w]*.?telegram.me/joinchat/%S+)$",
"^[!/#](setwelcome) (.*)",
"^[!/#](welcome) (.*)$"

},
run=run,
pre_process = pre_process
}

