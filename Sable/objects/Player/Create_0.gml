z = 0

xvel = 0;
yvel = 0;
zvel = 0;

lastdirx = 1;
lastdiry = 0;

bothx = 0;
bothy = 0;


anim = anim_idle;
old_anim = anim_idle;
anim_tick = 0; // every tick of animation
anim_frame = 0; // useful when the animation has no speed
anim_current_frame = 0; // frame in the scope of the current anim

image_speed = 0;
image_index = 0;

_data = "0";
_type = "Dirt";

footstepcreated = false;
movelock_time = 0;
hitflash_time = 0;
jump_time = 0;
landing_time = 0;
jumpingstate = 0;

characterstate = 0;

hitpoints = 50;
maxhitpoints = hitpoints;


spd = 2;

//--------Dialogue Stuff
reset_dialogue_defaults();
myVoice				= snd_voice2;
myFont				= fnt_dialogue;
myName				= "Sable";

myPortraitTalk		= spr_portrait_examplechar_mouth;
myPortraitTalk_x	= 26;
myPortraitTalk_y	= 44;
myPortraitIdle		= spr_portrait_examplechar_idle;
