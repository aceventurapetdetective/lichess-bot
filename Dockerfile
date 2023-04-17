FROM ubuntu:jammy
COPY . .

RUN apt-get update && apt-get upgrade -y && apt-get install -y wget unzip python3 python3-pip p7zip
RUN mv config.yml.default config.yml
RUN python3 -m pip install --no-cache-dir -r requirements.txt

# Stockfish - Depending on your CPU it may be necessary to pick a binary other than bmi2
RUN wget https://abrok.eu/stockfish/latest/linux/stockfish_x64_bmi2.zip -O stockfish.zip
RUN unzip stockfish.zip && rm stockfish.zip
RUN mv stockfish_* engines/stockfish && chmod +x engines/stockfish

RUN wget https://gitlab.com/OIVAS7572/Goi5.1.bin/-/raw/MEGA/Goi5.1.bin.7z -O Goi5.1.7z 
RUN 7zr e Goi5.1.7z && rm Goi5.1.7z

# Add the "--matchmaking" flag to start the matchmaking mode.
CMD python3 lichess-bot.py
