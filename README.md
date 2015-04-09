# paperworld3d
Exported from code.google.com/p/paperworld3d

The aim of the Paperworld project is to provide developers and designers with the tools to create realtime Multiplayer Games using Flash, Unity3D or the iPhone.... or all 3!

## Current release target is 0.7 and is due June '09

Paperworld can be used as a complete framework with which to build large games and applications or you can just use the individual libraries you need for your specific purpose without the overhead and learning curve of becoming familiar with yet another framework.

The Paperworld server runs as a service in any existing Red5 installation. By default Paperworld uses jMonkey as the 3D engine for running its simulations, but if you prefer you can create your own adaptor for any java-based 3D engine. If you need an adaptor for a particular 3D engine please get in touch, i'd be happy to help put one together for you.


## Features:

* A complete message-based connection API for Flash allows for easy customisation of handshake procedures and creating custom functionality just by creating a new type of message.
* Connect to Red5 from Unity3D or iPhone via UDP. Support more fast-twitch models than Flash can handle using datagrams instead of all that AMF overhead.
* Game AI - Steering Behaviours, Decision Making etc. etc. allow you to create complex behaviours for NPCs.
* Multiple controller support. More than just mouse and keys - use the wiimote, a custom joystick - even your iPhone!
* Connect it all together. Provide specific clients for each platform for the same game. Use each platform for its strengths.
