do 
local function user_99(msg, matches) 
if ( msg.text ) then
  if ( msg.to.type == "user" ) then
     return "🌐Welcome to IVR💡\n👥Developer bot : @lock_at_me_now & @THS_56 🔧🌚\n………………………………………………………\n🌐اهلا بك في الرد الالي💡 \n المطوين👥  @lock_at_me_now & @THS_56 🌚🔧"
    end 
  end 
end 
return { 
  patterns = { 
     "(.*)$"
  }, 
  run = user_99
} 

end 
