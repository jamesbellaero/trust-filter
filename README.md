<p style="text-align: center;">🟢Unclassified🟢</p>

// ****************************************************************************\
//\
// Cislunar Prop\
//\
// Copyright 2024 Infinity Labs, LLC. All rights reserved.\
//\
// The use, dissemination or disclosure of data in this file is subject to\
// limitation or restriction. See UTAUS-FA00002493 for details\
// ****************************************************************************

# Cislunar Prop
## Purpose
Cislunar Prop is meant to propagate satellites in orbits which follow the Center Restricted 3-body Problem or orbits in cislunar space.

## Contents
Nothing yet. Ideally it will contain code to download ephemeris for lunar position, code for determining lunar position and frame over time, conversions between the CRTBP rotating reference frame, ECEF, ECI, and Lunar-centered Lunar Fixed/Rotating frames.

Inputs to primary propagation algorithms will be states in relevant frames and start/end times. Outputs will be time histories. Propagation will be performed with RK45 unless it's shown to be insufficient.

## Use
Well, it's matlab, so either download octave or use matlab. There shouldn't be any library requirement.

## Frames
Conversions between rotating and inertial reference frames include a conversion for velocity.

Conversions between differently centered frames 

### ICRF - International Celestial Reference Frame
Inertial frame with respect to quasars. About as inertial as you can get.

### ECI  - Earth-centered Inertial
ICRF with geocentric origin. Used for earth-orbiting bodies (like the moon)

### ECEF - Earth-centered Earth-fixed
Rotating reference frame on Earth. Used for earth-based entities

### EMBR - Earth-Moon Barycenter Rotating
The rotating reference frame for the crtbp. Used for lagrange points

### LCLF - Lunar-centered Lunar-fixed
Used for entities on the lunar surface 

### LCI  - Lunar-centered Inertial
ICRF but centered at the moon. Used for satellites orbiting the moon (cislunar)


<p style="text-align: center;">🟢Unclassified🟢</p>
