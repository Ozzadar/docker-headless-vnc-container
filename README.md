# Docker containers with "headless" VNC session
The repository contains a collection of Docker images with headless VNC environments.

Each docker image is installed with the following components:

* Desktop environment [**Xfce4**](http://www.xfce.org)
* VNC-Server (default VNC port `5901`)
* [**noVNC**](https://github.com/kanaka/noVNC) - HTML5 VNC client (default http port `6901`)
* Java JRE 8
* Browsers:
  * Google Chrome v50.0.2661.94 

* __Ubuntu 14.04 with `Xfce4` UI session:__

  Run command with mapping to local port `5902`:

      docker run -d -p 7902:22 -p 5902:5901 -p 6902:6901 ozzadar/docker-headless-vnc-container:ubuntu

  Build image from scratch:

      docker build -t ubuntu-xfce-vnc ubuntu-xfce-vnc

  => connect via __VNC viewer `localhost:5902`__, default password: `vncpassword`

  => connect via __noVNC HTML5 client__: [http://localhost:6902/vnc_auto.html?password=vncpassword]()

  => connect via __ssh__: ```ssh localhost -p 7902 -l root``` , default password: root

### Hints
#### override the VNC password
Simple override the value of the environment variable `VNC_PW`. For example in
the docker run command:

    docker run -it -p 5911:5901 -p 6902:6901 -e "VNC_PW=my-new-password" ozzadar/docker-headless-vnc-container:ubuntu

### Contact
For questions or maybe some hints, feel free to contact us via **[sakuli@consol.de](mailto:sakuli@consol.de)** or open an [issue](https://github.com/ConSol/docker-headless-vnc-container/issues/new).

The guys behind:

**ConSol* Consulting & Solutions Software GmbH** <br/>
*Franziskanerstr. 38, D-81669 München* <br/>
*Tel. +49-89-45841-100, Fax +49-89-45841-111*<br/>
*Homepage: http://www.consol.de E-Mail: [info@consol.de](info@consol.de)*