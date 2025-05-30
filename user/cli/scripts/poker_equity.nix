{ pkgs, ... }:

let
  # Python Script to Calc Poker Equity
  ev-calc = pkgs.writers.writePython3Bin "ev-calc.py" { } /*python*/''
    import argparse


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
        main()
'';
in
{
  home.packages = [ev-calc];
}
