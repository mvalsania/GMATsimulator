# GMATsimulator

## Background

The first time I took the GMAT, I was really thrown off by the fact that the green dot next to my camera was on and by a few unexpected interruptions from my examiner. I did very poorly as a result. To prevent this from happening again—and because, let's admit it, GMATs are very expensive—I decided to create a script that would recreate the exam conditions.

## How?

- **Camera Activation:**  
  Activates the green dot on your MacBook (via `ffmpeg`) without recording, with all output redirected to `/dev/null`, for exactly 2.5 hours (for 3 45-minute sections, 1 10-minute break, and a little buffer; feel free to change the time to suit your needs).

- **Voice Interruptions:**  
  Randomly selects one Siri voice from a predefined list and interrupts the exam at 4 random times during the 2.5-hour period with GMAT examiner instructions. Each time you run the script, you will get an examiner with a different accent, chosen randomly, to further approximate the real exam experience.

## Requirements

- **macOS:**  
  Uses macOS-specific commands such as `say` and `ffmpeg`’s avfoundation input. The code is unfortunately only available for macOS, but feel free to suggest ways to make it more encompassing!

- **ffmpeg:**  
  Must be installed.  
  To install, run:  
  ```bash
  brew install ffmpeg
  ```

## How to Run the Code

### 1) Fork and Clone This Repo

### 2) Set Executable Permissions
Open your Terminal, navigate to the script's directory, and run:
```bash
chmod +x GMATsimulator.sh
```

### 3) Run the Script
In your Terminal, execute:
```bash
./GMATsimulator.sh
```
