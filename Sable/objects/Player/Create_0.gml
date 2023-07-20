z = 0

xvel = 0;
yvel = 0;
zvel = 0;

lastdirx = 1;
lastdiry = 0;

bothx = 0;
bothy = 0;

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
