extends Node2D

var hr:Array[int] = [0,0];
var min:Array[int] = [0,0];
var sec:Array[int] = [0,0];
var watchno = 1;
var watch_status =0;


@onready var watch1 = get_node("Watch1")
@onready var watch2 = get_node("Watch2")
@onready var status = get_node("ActiveWatch")

@onready var StartB = get_node("Start")
@onready var StopB = get_node("Stop")

#timers
@onready var S1 = $Sec1
@onready var S2 = $Sec2
@onready var M1 = $Min1
@onready var M2 = $Min2

var col;

func _ready():
	var color = watch2.get("theme_override_colors/font_color")
	col = color

func _process(delta):
	status.text = str("Active Watch: ",watchno," ,Status:",watch_status)
	$W1.hide()
	$W2.hide()
	watch1.set("theme_override_colors/font_color", col)
	watch2.set("theme_override_colors/font_color", col)
	if(watchno ==1):
		watch1.set("theme_override_colors/font_color", Color(8,8,8))
		$W1.show()
	else:
		watch2.set("theme_override_colors/font_color", Color(8,8,8))
		$W2.show()

func update1():
	watch1.text = str(hr[0],":",min[0],":",sec[0])

func update2():
	watch2.text = str(hr[1],":",min[1],":",sec[1])

func _on_start_pressed():
	watch_status =1
	StartB.text = "Started"
	StopB.text = "Stop"
	start_timer(watchno)


func _on_stop_pressed():
	watch_status =0;
	StopB.text = "Stopped"
	StartB.text = "Start"
	pause_timer(1)

func _on_reset_pressed():
	watch_status =0;
	sec[0]=0;
	min[0]=0;
	hr[0]=0;
	sec[1]=0;
	min[1]=0;
	hr[1]=0;
	StartB.text = "Start"
	StopB.text = "Stop"
	update1()
	update2()
	stop_timer()


func _on_swap_pressed():
	watchno = watchno%2 +1
	
	paused_timer(watchno)
	start_timer(watchno)
	#pause_timer((watch_status+1)%2)

func start_timer(a:int):
	
	
	S1.start()
	S2.start()
	
	M1.start()
	M2.start()
	paused_timer(a)

func paused_timer(a:int):
	S2.set_paused(a%2)
	S1.set_paused((a+1)%2)
	
	M2.set_paused(a%2)
	M1.set_paused((a+1)%2)

func pause_timer(a:int):
	S2.set_paused(a)
	S1.set_paused(a)
	
	M2.set_paused(a)
	M1.set_paused(a)

func stop_timer():
	S1.stop()
	S2.stop()
	M1.stop()
	M2.stop()

func _on_sec_1_timeout():
	sec[0]+=1
	update1()


func _on_sec_2_timeout():
	sec[1] +=1
	update2()


func _on_min_1_timeout():
	sec[0] =0
	min[0] +=1
	if(min[0]>60):
		min[0]=0;
		hr[0]+=1;
	update1()


func _on_min_2_timeout():
	sec[1] =0
	min[1] +=1
	if(min[1]>60):
		min[1]=0;
		hr[1]+=1;
	update2()
