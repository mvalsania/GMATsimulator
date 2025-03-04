# GMATsimulator

## Motivation

I wanted to recreate the exact exam conditions and be prepared for unexpected interruptions during a GMAT exam session.

## What the Code Does

- **Camera Activation:**  
  Turns on the camera (via `ffmpeg`) without recording, with all output redirected to `/dev/null`.

- **Voice Interruptions:**  
  Randomly selects one Siri voice from a predefined list and interrupts the exam at 4 random times with GMAT examiner instructions.

## Requirements

- **macOS:**  
  Uses macOS-specific commands such as `say` and `ffmpeg`’s avfoundation input.

- **Bash:**  
  The script is written in Bash.

- **ffmpeg:**  
  Must be installed.  
  To install, run:  
  ```bash
  brew install ffmpeg

## Executable Permissions

The script (GMATsimulator.sh) must have executable permissions.

## How to Run the Code

### Download the Script
Save the `GMATsimulator.sh` file to your desired directory.

### Set Executable Permissions
Open Terminal, navigate to the script's directory, and run:

```
chmod +x GMATsimulator.sh
```

### Run the Script
In Terminal, execute:

```
./GMATsimulator.sh
```

