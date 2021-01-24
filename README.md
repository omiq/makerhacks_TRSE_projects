# makerhacks_TRSE_projects

## BBC Text Mode unit

usage:
```@use textmode```

### Constants
OSBYTE: Entry point for OSBYTE http://beebwiki.mdfs.net/OSBYTE
OSWRCH: Print the char in accumulator 
OSNEWL: Newline carriage return + new line
OSASCI: Print text + CRNL at ch13 in string
CRTC_V: Video controller register
SCR_MO: screen mode register 
OSRDCH: Read Character
CUR_OF: Cursor off

### Functions/Procedures

	procedure cls()

	procedure move_to(_text_x: byte, _text_y: byte);

	procedure wait_vsync();

	procedure screen_mode(selected_mode:byte);

	procedure mode_1();
	procedure red();

	procedure yellow();

	procedure text_colour(_chosen_text_colour: byte);

	procedure get_ch(show_ch: byte = False);

	function get_string(): integer;

	procedure wait_key();

	procedure beep();

	procedure cursor_off();
