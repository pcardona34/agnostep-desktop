# agnostep
A GNUstep Desktop for All

Read [RELEASE](install/RELEASE) to know the current status.
- Alpha: means earlier developement stage. You should not use nor try, better is waiting.
- Beta: you may test to improve and help the project.
- Stable: Yet well tested. You can use it for a daily use. 

## The Goal
While announcing [PisiN Desktop](https://github.com/pcardona34/pi-step-initiative) at the GNUstep Discuss List, it happened that some people expressed the wish that the project was available too for other architectures, i.e. not only tied to the Raspberry Pi hardware.

So there is the attempt to accomplish the wish: an Agnostic GNUstep Desktop, named AGNoStep.

Now, AGNoStep is a GNUstep Desktop with a separate theme: [AGNOSTEP-theme](https://github.com/pcardona34/agnostep-theme).

So you can install the base desktop with a theme of your choice, or apply the in purpose theme above.

But also, you can try to apply this theme on other GNUstep compliant desktops. Of course, this new feature is in earlier stage and it may be buggy. Do not hesitate to create [issues](https://github.com/pcardona34/agnostep-theme/issues) to improve it.

## Available for Raspberry Pi's too

As AGNoStep was forked from the deprecated [PiSiN](https://github.com/pcardona34/pi-step-initiative) project, you can still install it on a Rasbberry Pi.

## Hardware compatibility list

I cannot promise AGNoStep will install and function on your hardware.
So we shall establish a real working list.

But if you can run Debian Trixie on your computer, we can say with optimism that AGNoStep should run on too. See [HCL](install/HCL) for a real hardware tested list.

## How to install

Read [INSTALL](install/INSTALL) first.

Quick way: on a fresh minimal Debian Trixie (13.x) on a computer wired to Internet, execute:
````	
	cd install
	./enjoy.sh
````

Than logout the desktop if all is ok, and install the Display Manager:

````
	./7_install_DM.sh
````

## Screenshots

See [AGNOSTEP-theme screenshots](https://github.com/pcardona34/agnostep-theme/blob/main/Screenshots)...
