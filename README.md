# The Plan:

Butchering the vocabulary in order to accomodate my thoughts for now. Subject
to intense change until I lose interest on Thursday, probably.

## Build a local meshnet with useful services that do not require the internet.

  1. Build my personal home/lab net out to cover the entire span of my
   neighborhood by purchasing 1 MT7688 router dev board a month until I am out
   of film canisters.
  2. Transparently connect to residential PC's using the same URL/Domain
   everywhere. Preferably human-readable and doing authentication at another
   layer.
  3. Allow others to use my infrastructure to set up their own networks and
   optionally make them available on the mesh.

Why Today? Well, KRACK maybe was the immediate impetus. But more broadly, I want
to put in place a policy for deploying services I wish to keep available to me
on my network, and a procedure for updating and or rebooting the network.


## Guides:

  * Building using this repository: Coming Soon
  * [Travel Router Assembly Gallery](https://github.com/eyedeekay/lede-docker/blob/master/Pages/ASSEMBLY_OMEGA2P.md): Images only so far

## Services:

### Services Goals:

  * Transparent Global Addressability
  * No dependence on Wireless crypto between devices for confidentiality
  * Interconnectivity

### Service Requirements:

#### Required for all routers except Repeaters and Spoofers:

  * luci-ssl
  * openSSH Server(not Dropbear)
  * tinc
  * kadnode*
  * cjdns

#### Recommended for all routers except Repeaters and Spoofers:

  * openVPN
  * p910nd
  * squid

## Policies:

### Policy Goals

### Informal Policy / Genesis of the Plan:

Before I continue, the whole purpose of this policy is to make it possible for
me to do ill-advised things with my own network without disrupting my room mates
ability to use it.

For most of my adult life, I've gone to pretty great lengths to avoid disrupting
the internet service available to my room mates. Even when I pay for it. Part of
that means that I can't experiment on the router unless I have a backup, which
means that in order to even start customizing one router, I have to have another
router ready to drop in in such a way that they won't notice. Which requires at
least 2 routers to accomplish. This is good enough to make it work, but a little
limiting. So as soon as it was possible, I started a 3 router basic
configuration, wherin the third router is called the Lab Router and is
especially required to be readily recovered in the event of a brick, and am
devising an optional, broader, fourth configuration for expanding the network
using hardware I don't integrate here with the intention of expanding the
network both wired and wirelessly. I don't plan to enforce any aspect of this
on anyone else's devices should they choose to participate in the meshnet.

  1. Home Router: This is the router that connects to the modem, and which
  is used to share the residential internet connection. This router is kept
  "Stable" which here means that it gets updates that are built only from
  official sources with isolated toolchains to avoid library interference, and
  only recieves customizations from selfhosted repositories, and not from
  packages built into the firmware image. In my lab, this is a Netgear WNR3800.
  2. Backup/Spoofer Router: This one is manually configured to have identical
  settings to Home Router in a known good configuration, so that it can take the
  place of Home Router if it's down for maintenance. It only runs a stock
  version of lede with no third-party packages, even if they're included on the
  Home Router, in order to make as absolutely sure as possible that this router
  will *always* boot. In my lab, this is a pre-configured WNDR2000, which is
  the same router that suffered the 4/32 defect. Being the spoofer is about the
  only thing it's still useful for in this setup.
  3. Lab Router: This router only connects my personal devices to the Home
  Router network, and provides some additional capabilites by running it's own
  services. It also serves as a testing area for strategies and changes that
  will be migrated to the Home Router. In my lab, this is the role of the Onion
  Omega2.
  4. \+ Mesh Routers/Mesh Servicers:
   * Servicer: A servicer is a device which does at least 2 things: Host an
    outward-facing service and share it's wider network connection in any way.
    An example might be an old laptop running apt-cacher-ng, plugged into a Home
    Router, and serving up an access point. These devices can run any Linux
    based operating system, including those which mix in non-free software.
   * Mesher: A mesher is a device which both recieves a network connection and
    shares it with nearby devices, and which does both of these things
    wirelessly. This must be running LEDE, LibreCMC, Debian, or Alpine Linux.
   * Repeater: Repeaters are devices which are used in the same way as a Mesher,
    but which for whatever reason cannot qualify as meshers. These are things
    like the secondhand Belkin N600 I set up with DD-WRT in the garage.

So the other day I went and purchase an Onion Omega2+ gadget and the mini power
adapter to use as a new laboratory router, since my old one was having issues
due to the [4/32](https://lede-project.org/meta/infobox/432_warning) problem. I
was mostly not disappointed! Which is a big deal for me, I am prone to extreme
dissatisfaction. This little gadget is insanely easy to use. That's not to say
it doesn't have a few rough edges, I found getting the wireless to work with
stock LEDE a little confusing, but it's a nice little device and appealingly,
it generates almost no heat and fits comfortably within a film canister. Perhaps
even more appealingly, the little guy is like 12 USD without the power adapter.
And there's another company with an almost identical product called Seeed Studio
which is about 14 USD retail, and it comes with power over usb built right in!
And for a travel router, this thing has quite a bit of capability.


## formerly my lede-docker Dockerfiles repository

