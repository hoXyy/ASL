state("SaintsRowIV", "Current Steam")
{
	int isLoad : 0x12B2314; 
	bool zeroIfComplete : 0x12C0928;
	string32 currentDialogue : 0x3BDEC30;
	int zinyakDed : 0x375E4F8;
	string32 missionBank : 0x14101CD;
	int startCheck : 0x12A4920;
	int passCheck : 0x12F281C;
}

state("SaintsRowIV", "Pre-Workshop cracked")
{
	int isLoad : 0x51C3D6C;
	bool zeroIfComplete : 0x51D2200; // or 51BB044
	string32 currentDialogue : 0x7AE6F90;
	int zinyakDed : 0x76902B8;
	string32 missionBank : 0x532409D;
	int startCheck : 0x51BABA0;
	int passCheck : 0x5211798;
}

startup
{
    vars.aslName = "Saints Row IV Autosplitter";
    if(timer.CurrentTimingMethod == TimingMethod.RealTime)
        {
            var timingMessage = MessageBox.Show(
                "This game uses Game Time (time without loads) as the main timing method.\n"+
                "LiveSplit is currently set to show Real Time (time INCLUDING loads).\n"+
                "Would you like the timing method to be set to Game Time for you?",
                vars.aslName+" | LiveSplit",
                MessageBoxButtons.YesNo,MessageBoxIcon.Question
            );
            if (timingMessage == DialogResult.Yes) timer.CurrentTimingMethod = TimingMethod.GameTime;
	}
}

init
{
	if (modules.First().ModuleMemorySize == 133226496)
	{
		version = "Pre-Workshop cracked";
	}
	if (modules.First().ModuleMemorySize == 67198976)
	{
		version = "Current Steam";
	}
	
	vars.rewardCheck = false;
}

update
{
	if (!current.zeroIfComplete && old.zeroIfComplete)
	{vars.rewardCheck = true;}
}

split
{

	if
	(	
		vars.rewardCheck && current.passCheck == 4000
	)
	{
		vars.rewardCheck = false;
		return true;
	}
	
	if
	(
		(current.missionBank == "m15_3_media.bnk_pc" && old.missionBank == "m15_1_media.bnk_pc")
		||
		(current.missionBank == "m17_media.bnk_pc" && old.missionBank == "m16_media.bnk_pc")
		||
		(current.missionBank == "m22_2_media.bnk_pc" && old.missionBank == "m22_1_media.bnk_pc")
		||
		(current.missionBank == "m22_3_media.bnk_pc" && old.missionBank == "m22_2_media.bnk_pc")
		||
		(current.missionBank == "m23_media.bnk_pc" && old.missionBank == "m22_3_media.bnk_pc")
	)
	return true;
}

isLoading
{
	return current.isLoad == 101 && current.zeroIfComplete;
}

start
{
	return current.missionBank == "m00_media.bnk_pc" && current.startCheck != old.startCheck && old.startCheck == 1;
}

reset
{
	return current.missionBank == "m00_media.bnk_pc" && old.missionBank == "";
}
