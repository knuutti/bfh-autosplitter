// LEGO Harry Potter: Battle for Hogwarts Auto Splitter
// Supports the Flash version of the game
// Script by Knuutti

// Version: 1.0

state("flashplayer_32_sa") 
{
    int level_id    : 0x00D183C8, 0x4, 0x8C, 0x3AC, 0x204, 0x378, 0xEC, 0x4C;
}

startup 
{
    //Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
    settings.Add("Splits", true, "Splits (SELECT ONLY ONE)");
	settings.CurrentDefaultParent = "Splits";
    settings.Add("AllStages", false, "All Stages");
    settings.Add("FinalStage", true, "Final Stage");
	settings.CurrentDefaultParent = null;
}

update
{
    if(current.level_id == 3) {
        if(vars.run_started == true) {
            vars.game_beaten = false;
            vars.run_started = false;
        }
        if(DateTime.Now - vars.main_menu_start_time > new TimeSpan(0,0,0,0,100)) {
            vars.reset_possible = true;
        }
    }
    else {
        vars.main_menu_start_time = DateTime.Now;
    }

    // Debug stuff
    //timer.SetGameTime(new TimeSpan(0,0,current.level_id-4));
}

init
{
    vars.run_started = false;
    vars.game_beaten = false;
    vars.main_menu_start_time = DateTime.Now;
    vars.level = 0;
    vars.reset_possible = false;
}

split
{
    if(settings["AllStages"] &&
        ((current.level_id == 6 && vars.level == 1) ||
        (current.level_id == 7 && vars.level == 2) ||
        (current.level_id == 8 && vars.level == 3) ||
        (current.level_id == 9 && vars.level == 4) ||
        (current.level_id == 10 && vars.level == 5) ||
        (current.level_id == 11 && vars.level == 6) ||
        (current.level_id == 12 && vars.level == 7) ||
        (current.level_id == 13 && vars.level == 8) ||
        (current.level_id == 14 && vars.level == 9) ||
        (current.level_id == 16 && vars.level == 10)))
    {
        vars.level += 1;
        if(vars.level == 11) {
            vars.game_beaten = true;
        }
        return true;
    }
    else {
        if(current.level_id == 16) {
            vars.game_beaten = true;
            return true;
        }
    }


}

start
{
    if(current.level_id == 5) {
        if(vars.run_started == false) {
            vars.run_started = true;
            vars.level = 1;
            vars.reset_possible = false;
            return true;
        }
    }
}

reset
{
    if(current.level_id == 3 && vars.reset_possible == true) {
        vars.run_started = false;
        vars.reset_possible = false;
        return true;
    }
}
