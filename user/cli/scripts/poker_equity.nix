{ pkgs, ... }:

let
  # Python Script to Calc Poker Equity
  ev-calc = pkgs.writers.writePython3Bin "poker.py" {

    # Python libraries
    libraries = [
      pkgs.python3Packages.ollama
    ];

  } /*python*/''
    import argparse
    import base64
    import ollama


    IMAGE = "/home/wally/Pictures/Screenshots/2025-06-12-194853_hyprshot.png"
    POKER_PROMPT = """
        You are a professional Texas Holdem Poker player.
        Poker GTO strategies are your second nature.
        Analyse the following poker situation from the picture.
        How many players are there?
        What hand does OffTheWall211 have?
        What ist the flop?
    """
    PROMPT = "I am OffTheWall211 what are my cards?"


    def get_args():
        """ Get cmd args... """
        parser = argparse.ArgumentParser(description="EV Poker Calc.")
        parser.add_argument("--outs", "-o",
                            required=True, type=int, help="Outs number...")
        parser.add_argument("--pot", "-p",
                            required=True, type=int, help="Pot size...")
        parser.add_argument("--bet", "-b",
                            required=True, type=int, help="Bet size...")
        return parser.parse_args()


    def percentage(percent, total):
        """ Calculate percentage """
        return round((percent / 100) * total, 2)


    def main():
        """ Main Function """
        args = get_args()

        outs = args.outs * 2
        pot = args.pot + args.bet
        win = percentage(outs, pot)
        lose = percentage(100 - outs, args.bet)

        ev = round(win - lose, 2)

        print(f"Outs: {outs}%")
        print(f"Win: {outs}% * {pot}$ = {win}$")
        print(f"Lose: {100 - outs}% * {args.bet}$ = {lose}$")

        print(f"Expected Value: {win}$ - {lose}$ = {ev}$")


    if __name__ == "__main__":
        """ Entrypoint... """
        # main()
        print("# => Starting the ai...")
        with open(IMAGE, "rb") as img:
            img_data = img.read()
        img_base64 = base64.b64encode(img_data).decode('utf-8')

        response = ollama.generate(
            model="gemma3:latest",
            prompt=POKER_PROMPT,
            images=[img_base64],
            options={"temperature": 0.1}
        )
        print("# => Print ai response...")

        caption = response['response'].strip()
        print(caption)
'';
in
{
  home.packages = [ev-calc];
}
