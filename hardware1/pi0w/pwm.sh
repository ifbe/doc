gpio mode 23 in
gpio mode 24 in
gpio mode 26 in

#gpio mode 24 pwm
#gpio pwm-ms
#gpio pwmc 1920
#gpio pwmr 10000
#gpio pwm 23 2500

gpio mode 23 pwm
gpio pwm-ms
gpio pwmc 1920		#19.2mhz / 1920 = 10000hz
gpio pwmr 10000		#10000mhz / 10000 = 1hz
gpio pwm 23 9900
