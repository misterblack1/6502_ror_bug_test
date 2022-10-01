# Boot rom for Apple II to test for 6502 ROR instruction bug

This code was created by Frank IZ8DWF to test 6502 processors to see if they contain the ROR instruction bug. 

Early 6502 chips (until about May or June 1976) contained a bug where the ROR instruction didn't behave correctly. Because of this, MOS did not include the ROR instruction on the list of 6502 instructions, even though people knew it was supposed to be there. 

This ROM which is designed for the Apple II will initialize the system and then test the CPU for this bug. It will then simply display a message telling you which CPU you are running. 

The ROM does not do anything else.

The BIN file can be flashed onto a 2764 or 2864 and installed into the EF ROM rocket on an Apple IIe. It should work just fine on the original Apple II and II+, but you will need to figure out how to get the code into the F0XX ROM space as these computer use custom ROM chips.

Frank IZ8DWF's YouTube channel:
https://www.youtube.com/c/iz8dwf/videos
