# agnostep
A PiSiN like Desktop for All

Read [RELEASE](install/RELEASE) to know the current status.
- Alpha: means earlier developement stage. You should not use nor try, better is waiting.
- Beta: you may test to improve and help the project.
- Stable: Yet well tested. You can use it for a daily use. 

## The Goal
While announcing [PisiN Desktop](https://github.com/pcardona34/pi-step-initiative) at the GNUstep Discuss List, it happened that some people expressed the wish that the project was available too for other architectures, i.e. not only tied to the Raspberry Pi hardware.

So there is the attempt to accomplish the wish: an Agnostic GNUstep Desktop, named AGNoStep.

## Available for Raspberry Pi's too

With the latest release of AGNoStep, you can also install it on a Rasbberry Pi. The  [PiSiN](https://github.com/pcardona34/pi-step-initiative) project will be frozen and new features only will become on AGNoStep.

## Hardware compatibility list

I cannot promise AGNoStep will install and function on your hardware.
So we shall establish a real working list.
But if you can run Debian Trixie on your computer, we can say with optimism that AGNoStep should run on too. See [HCL](install/HCL) for a real hardware tested list.

## How to install

Read [INSTALL](install/INSTALL) first.

Quick way: on a fresh minimal Debian Trixie (13.1) on a computer wired to Internet, execute:
	
	cd install
	./enjoy.sh

Than logout the desktop if all is ok, and install the Display Manager:

	./7_install_DM.sh


## Screenshots

![AGNoStep Desktop on Debian Trixie](Screenshots/screenshot_agnostep_debian13.png)
[More screenshots](Screenshots)
