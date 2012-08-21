2012/08/19 -- hefe-kernel-v0.8.1

  Resolved issues with UV control for 3rd-party apps
    * System Tuner and Voltage Control confirmed working

  AOKP ROM Control not working
    * Appears to be a ROM issue ("wrong" sysfs being read/written)
  

2012/08/17 -- hefe-kernel-v0.8.0 

  Initial release -- http://forum.xda-developers.com/showthread.php?t=1837873

  Features:
    * Linux 2.6.35.7 kernel, based on TeamAcid CM9/AOKP kernel
    * MTD, intended for ICS
    * Overclock (OC) (can set through AOKP ROM Control)
    * Undervolt (UV) (see Known Issues)
    * Advanced governor options
      * SmartassV2
      * OndemandX
      * Intellidemand
      * Lulzactive
    * Kernel optimization

  Known Issues:
    * AOKP ROM Control can't read or set UV levels
    * Most 3rd-party apps have issues with setting or displaying UV levels
    * Minimum CPU speed permitted "randomly" changes between 100 and 200 MHz
    * VCO may false lock on OC speeds (just as AntonX's GB kernel will)
    * Doesn't have the PowerVR drivers yet
    * Intellidemand and Lulzactive drivers were felt by AntonX to be 
        too unreliable for daily use
    * Not a drop-and-go install if your non-TeamAcid ROM 
        isn't using the bcm4329 driver
    * Most anything that is a known issue with the TeamAcid ICS kernel

  Thanks:
    * TeamAcid, for bringing ICS and AOKP to the phone at all
    * TeamAcid, for actually posting their sources, in full
    * AntonX, for taking the time to add OC/UV functionality to the GB kernel
    * Teamhacksung, for various drivers and bits
    * TeamAcid, for hopefully not complaining that 
        I didn't replace their boot logos
    * Bhundven, for pulling everything together 
        and his ongoing work on a 3.x kernel


Build in TeamAcid's AOKP build environment. 
Likely builds in CyanogenMod and AOSP environments.


Original README.md -- git blames bhundven

# Reset - v0.4.1 MTD

Welcome to the Reset of the Subtly Modified Stock kernel.

I started this project with the mindset of embedded linux, and at the bottom end of the android system learning curve.

Since then I've learned a lot about android and found a lot of my changes to understand what android expects may have been causing more problems then solutions.

The Reset kernel went all the way back to the initial Samsung T959VUVKJ6 source drop. Only adding on bits that worked.

More to come here...
