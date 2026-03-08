settingling for 
720p
15fps
80q webp

pros:
- fairly smooth
- quality suffices
- small file size (git works without 7z)
- more colors compared to gif
- under 1%cpu usage on my laptop (would 0.1% or sth on my PC)

cons:
- slight noise in the image
- almost 850GB decoded cache for a 16s webp


**considerations:**
visual studio on single file console programm with 400 lines
consumed on avrg 3% CPU just by continuesly scrolling
whereas nvim consumes almost nothing.
even on my laptop it stays under 1% while rendering the webp


as countermease for the large cache size:
I might clear it on wezterm start up. So I usually start wezterm once per day,
considering i change the background once or trice, it will store 1-3GB in the worst case.
BUt clearing it back up everyday, so I can use an infinite amount of different backgrounds
without polluting the cache

