name = "Disciple";

ai_x = 0;
ai_y = 0;

z = 0;

xvel = 0;
yvel = 0;
zvel = 0;

lastdirx = 1;
lastdiry = 0;

is_dead = 0;

jump_time = 0;
jumpingstate = 0;
_onfloor = 0;
_timesince_onfloor = 0;
_onceiling = 0;

draw_slash = 0;
attack_time = 0;
characterstate = 0;

hitpoints = 50;
maxhitpoints = hitpoints;

hitflash_time = 0;
movelock_time = 0;

stopsoundplayed = false;

anim = anim_idle;
old_anim = anim_idle;
anim_tick = 0; // every tick of animation
anim_frame = 0; // useful when the animation has no speed
anim_current_frame = 0; // frame in the scope of the current anim

image_speed = 0;
image_index = 0;

event_inherited(); //so it will inherit from par_speaker


//-------DIALOGUE STUFF

myPortraitTalk		= spr_portrait_examplechar_mouth;
myPortraitTalk_x	= 26;
myPortraitTalk_y	= 44;
myPortraitIdle		= spr_portrait_examplechar_idle;

myVoice				= snd_acolight_voice;
myName				= "Acolight";

//-------OTHER

choice_variable		= -1;	//the variable we change depending on the player's choice in dialogue