# EZ-MCXN

This repository contains NXP MCXN related content.

# MCXN236 Test Board

This test board is intended for trying out the MCXN236VKLT microcontroller (100-pin HLQFP 0.5 mm package). The 235 variant is also possible, and there's a good chance the MCXN547VKLT microcontroller will work too.

![0.75](images/kicad_render.png)

# MCX Projects

This folder contains a board config and example blinky application source code. The folders may be hard-coded in places; the mcx\_projects folder can be placed at c:\dev\projects to keep things seamless, otherwise you may need to edit files.

# Environment Variables

The following user vars (environment variables) may need to be created:

`ARMGCC_DIR = C:\DEV\arm_gnu_toolchains\15.2.rel1 `(this folder should contain bin, include, lib folders and so on)

`MCUXPRESSO_SDK_ROOT = C:\dev\projects\mcuxpresso-sdk\mcuxsdk`

