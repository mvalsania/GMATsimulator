#!/bin/bash
# Ensure this script remains executable on subsequent runs
chmod +x "$0"

# -----------------------------
# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
  echo "Error: ffmpeg is not installed."
  echo "Please install ffmpeg using Homebrew by running:"
  echo "  brew install ffmpeg"
  exit 1
fi

# -----------------------------
# Define the list of available voices
voices=(
"Albert"
"Alice"
"Alva"
"Amélie"
"Amira"
"Anna"
"Bad News"
"Bahh"
"Bells"
"Boing"
"Bubbles"
"Carmit"
"Cellos"
"Damayanti"
"Daniel"
"Daria"
"Wobble"
"Eddy (German (Germany))"
"Eddy (English (UK))"
"Eddy (English (US))"
"Eddy (Spanish (Spain))"
"Eddy (Spanish (Mexico))"
"Eddy (Finnish (Finland))"
"Eddy (French (Canada))"
"Eddy (French (France))"
"Eddy (Italian (Italy))"
"Eddy (Portuguese (Brazil))"
"Ellen"
"Flo (German (Germany))"
"Flo (English (UK))"
"Flo (English (US))"
"Flo (Spanish (Spain))"
"Flo (Spanish (Mexico))"
"Flo (Finnish (Finland))"
"Flo (French (Canada))"
"Flo (French (France))"
"Flo (Italian (Italy))"
"Flo (Portuguese (Brazil))"
"Fred"
"Good News"
"Grandma (German (Germany))"
"Grandma (English (UK))"
"Grandma (English (US))"
"Grandma (Spanish (Spain))"
"Grandma (Spanish (Mexico))"
"Grandma (Finnish (Finland))"
"Grandma (French (Canada))"
"Grandma (French (France))"
"Grandma (Italian (Italy))"
"Grandma (Portuguese (Brazil))"
"Grandpa (German (Germany))"
"Grandpa (English (UK))"
"Grandpa (English (US))"
"Grandpa (Spanish (Spain))"
"Grandpa (Spanish (Mexico))"
"Grandpa (Finnish (Finland))"
"Grandpa (French (Canada))"
"Grandpa (French (France))"
"Grandpa (Italian (Italy))"
"Grandpa (Portuguese (Brazil))"
"Jester"
"Ioana"
"Jacques"
"Joana"
"Junior"
"Kanya"
"Karen"
"Kathy"
"Kyoko"
"Lana"
"Laura"
"Lekha"
"Lesya"
"Linh"
"Luciana"
"Majed"
"Tünde"
"Meijia"
"Melina"
"Milena"
"Moira"
"Mónica"
"Montse"
"Nora"
"Organ"
"Paulina"
"Superstar"
"Ralph"
"Reed (German (Germany))"
"Reed (English (UK))"
"Reed (English (US))"
"Reed (Spanish (Spain))"
"Reed (Spanish (Mexico))"
"Reed (Finnish (Finland))"
"Reed (French (Canada))"
"Reed (Italian (Italy))"
"Reed (Portuguese (Brazil))"
"Rishi"
"Rocko (German (Germany))"
"Rocko (English (UK))"
"Rocko (English (US))"
"Rocko (Spanish (Spain))"
"Rocko (Spanish (Mexico))"
"Rocko (Finnish (Finland))"
"Rocko (French (Canada))"
"Rocko (French (France))"
"Rocko (Italian (Italy))"
"Rocko (Portuguese (Brazil))"
"Samantha"
"Sandy (German (Germany))"
"Sandy (English (UK))"
"Sandy (English (US))"
"Sandy (Spanish (Spain))"
"Sandy (Spanish (Mexico))"
"Sandy (Finnish (Finland))"
"Sandy (French (Canada))"
"Sandy (French (France))"
"Sandy (Italian (Italy))"
"Sandy (Portuguese (Brazil))"
"Sara"
"Satu"
"Shelley (German (Germany))"
"Shelley (English (UK))"
"Shelley (English (US))"
"Shelley (Spanish (Spain))"
"Shelley (Spanish (Mexico))"
"Shelley (Finnish (Finland))"
"Shelley (French (Canada))"
"Shelley (French (France))"
"Shelley (Italian (Italy))"
"Shelley (Portuguese (Brazil))"
"Sinji"
"Tessa"
"Thomas"
"Tingting"
"Trinoids"
"Whisper"
"Xander"
"Yelda"
"Yuna"
"Zarvox"
"Zosia"
"Zuzana"
)

# Randomly select a voice for this run
selected_voice="${voices[$RANDOM % ${#voices[@]}]}"
echo "Selected voice: $selected_voice"

# -----------------------------
# Start camera capture for 2.5 hours (9000 seconds)
# This command uses macOS's avfoundation via ffmpeg.
echo "Starting camera capture for 2.5 hours..."
ffmpeg -f avfoundation -framerate 30 -video_size 1280x720 -i "0" -t 9000 -f null /dev/null > /dev/null 2>&1 &
CAMERA_PID=$!

# -----------------------------
# Define the GMAT examiner instructions
rules=(
"Maintain full visibility of your face and shoulders within the camera frame at all times."
"Any form of verbal communication—including whispering or self-directed speech—is strictly prohibited."
"Even the slightest lip movement is not allowed throughout the testing session."
"Ensure that no unauthorized materials or electronic devices are visible in your testing area."
"Keep your hands and any personal items within the camera’s view at all times."
"Remain seated and avoid unnecessary movements that might obstruct your face from the camera."
"Do not use any non-verbal signals, gestures, or facial expressions to communicate."
"Your microphone must remain muted unless you are explicitly instructed otherwise."
"Follow all on-screen directions and examiner commands without delay."
"In the event of a technical issue, notify the proctor immediately using the designated channel."
)

total_time=9000   # 2.5 hours in seconds
num_comments=4    # Total number of voice announcements

# Generate 4 random times (in seconds) within the total time span
times=()
for i in $(seq 1 $num_comments); do
  random_time=$(( RANDOM % (total_time + 1) ))
  times+=("$random_time")
done

# Sort the times in ascending order so they occur in chronological order
IFS=$'\n' sorted_times=($(sort -n <<<"${times[*]}"))
unset IFS

prev=0
for t in "${sorted_times[@]}"; do
  # Calculate sleep time from the previous announcement (or start)
  sleep_time=$(( t - prev ))
  sleep "$sleep_time"
  
  # Randomly select one GMAT rule instruction
  selected_rule="${rules[$RANDOM % ${#rules[@]}]}"
  
  # Use the randomly selected voice to speak the instruction
  say -v "$selected_voice" "$selected_rule"
  
  prev="$t"
done

# Wait for the camera capture to finish (if it hasn't already)
wait $CAMERA_PID

