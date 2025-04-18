thinklight=/sys/class/leds/tpacpi::thinklight/brightness
declare -i state=$(< $thinklight)
state=!$state
echo $state > $thinklight

