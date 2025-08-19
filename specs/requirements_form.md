# Project Requirements Form

## Basic Project Information

**Project Name:** 
TV Assassin

**Project Type:** 
Mobile app

**Primary Purpose/Goal:** 
With one button, use the devices ir blaster to send as many TV shutoff signals as possible targeting as many different TVs as possible.

**Target Users:** 
Hackers and bored nerds who want to turn off TVs quickly and easily.

## Functional Requirements

**Core Features:** 
Initial detection of IR blaster device feature and showing feedback of sussessful detection or a friendly error message.

One big button to send the signals using the IR blaster.

Multiple shutoff signals valid for different brands and models of TVs.

**User Stories:** 
Upon launching the app, the user is immediately presented with a single large button with a skull icon and a label of "Kill TVs". The user can then tap the button to send the shutoff signal to all TVs in general direction that the IR blaster is pointed at. The button should be momentarily disabled unless the sending of signals takes less than 500 milliseconds.

**Data Requirements:** 
Needs a list of TV shutoff signals applicable to different common brands and models of TVs.

**Integration Requirements:** 
Must be able to detect the presence of an IR blaster device and access that device to send the shutoff signal.

## Technical Constraints

**Technology Stack Preferences:** 
Flutter, Material Design, Dart, Android

**Platform Requirements:** 
Android

**Performance Requirements:** 
Needs to be very fast and small

**Security Requirements:** 
no extra data or access rights, only access to the device's IR blaster and the list of shutoff signals.

## Non-Functional Requirements

**Usability Requirements:** 
Big visible centered button as main interface.
It needs to have a theme switch button on the right side of the app bar. Must default to system theme settings, then toggle between ligth and dark themes using the theme switch button.

**Reliability Requirements:** 
Simple and reliably fast. Avoid extra features or complexity.

**Scalability Requirements:** 
None

**Maintenance Requirements:** 
None. I do not expect much development beyond simple feature completeness. Altering the list of shutoff signals may be a future possibility.

## Project Constraints

**Timeline:** 
One day

**Budget/Resource Constraints:** 
None

**Regulatory/Compliance Requirements:** 
None. Must be able to be released as an open source app, compliant with F-Droid requirements.

## Success Criteria

**Definition of Done:** 
APK builds without errors and warnings.
App works as expected.

**Key Metrics:** 
load time under 300ms
APK under 50mb

**Acceptance Criteria:** 
N/A

## Additional Context

**Existing Solutions:** 
Universal remote control apps exist, but they would not work for this purpose.

**Assumptions:** 
None

**Risks and Concerns:** 
None.

**Future Considerations:** 
May need to modify the list of shutoff signals in the future.

---

**Form Completion Date:** 
2025-08-19

**Completed by:** 
James Smith
