extends Node2D

var hr:Array[int] = [0,0];
var min:Array[int] = [0,0];
var sec:Array[int] = [0,0];
var watchno = 1;
var watch_status =0;
@onready var watch1 = get_node("Watch1")
@onready var watch2 = get_node("Watch2")
@onready var status = get_node("ActiveStatus")




func update_watch1():
	if sec[0]>60:
		sec[0]=0;
		min[0]+=1;
	if min[0]>60:
		min[0]=0;
		hr[0]+=1;
	watch1.text = str(hr[0],":",min[0],":",sec[0])

func update_watch2():
	if sec[1]>60:
		sec[1]=0;
		min[1]+=1;
	if min[1]>60:
		min[1]=0;
		hr[1]+=1;
	watch2.text = str(hr[1],":",min[1],":",sec[1])

func _on_sec_timeout():
	if(watch_status):
		if(watchno==1):
			sec[0] +=1
			update_watch1()
		else:
			sec[1] +=1
			update_watch2()

func _on_start_pressed():
	watch_status =1;
	$sec.start()
	status.text = str("Active Watch:", watchno," state:",watch_status)

func _on_swap_active_pressed():
	watchno = (watchno%2) + 1
	status.text = str("Active Watch:", watchno," state:",watch_status)

func _on_pause_pressed():
	watch_status =0;
	$sec.stop()
	status.text = str("Active Watch:", watchno," state:",watch_status)

func _on_resume_pressed():
	watch_status = 1;
	$sec.start()
	status.text = str("Active Watch:", watchno," state:",watch_status)







func _on_reset_pressed():
	watch_status =0;
	sec[0] = 0;
	min[0] = 0;
	hr[0] =0;
	sec[1] =0;
	min[1] =0;
	hr[1] =0;
