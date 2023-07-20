name = "Disciple";

ai_x = 0;
ai_y = 0;

xvel = 0;
yvel = 0;
lastdirx = 1;
lastdiry = 0;

characterstate = 0;

hitpoints = 50;
maxhitpoints = hitpoints;

hitflash_time = 0;
movelock_time = 0;




event_inherited(); //so it will inherit from par_speaker


//-------DIALOGUE STUFF

myPortraitTalk		= spr_portrait_examplechar_mouth;
myPortraitTalk_x	= 26;
myPortraitTalk_y	= 44;
myPortraitIdle		= spr_portrait_examplechar_idle;

myVoice				= snd_disciple_voice;
myName				= "Acolight";

//-------OTHER

choice_variable		= -1;	//the variable we change depending on the player's choice in dialogue