"""Check that every event-triggered Lua action ends its queued run with `self.used = true`.

TensorReactions queues a reaction when its event fires (cast, channel, tether, map effect, ...).
A Lua action that never sets `self.used = true` is run again on every game tick with the same
event until the reaction's time window ends. Captures then record the same event over and over,
AutoSim syncs count one cast many times, and targeting keeps forcing the target.

OnUpdate, OnFrame and OnDraw reactions are polled every frame by design and are not checked.

Usage:
  python check_event_reactions.py                 check TimelineReactions/ and GeneralReactions/ here
  python check_event_reactions.py FILE [FILE ...] check the given profile files

Exit code 0 when nothing is found, 1 when at least one reaction needs fixing.
"""
import glob
import os
import re
import sys

EVENTS = {1: "OnUpdate", 2: "OnEntityCast", 3: "OnEntityChannel", 4: "OnEntityMarkerAdd", 5: "OnEntityAdd",
          6: "OnEntityRemove", 7: "OnNewChatLine", 8: "OnNewBuffEntry", 9: "OnWipe", 10: "OnDeath",
          11: "OnMapChange", 12: "OnFrame", 13: "OnDraw", 14: "OnMapEffect", 15: "OnTetherChange",
          16: "OnCountdown", 17: "OnCountdownCancel", 18: "OnAOECreate", 19: "OnEventObjectScript",
          20: "OnEventObjectScript2", 21: "OnFloorChange", 22: "OnVisibilityChange", 23: "OnAnimationChange",
          24: "OnTransformChange", 25: "OnAuraChange", 26: "OnTargetableChange", 27: "OnAddEntityVFX",
          28: "OnAddGroundVFX", 29: "OnAddGroundEffect"}
POLLED = {"OnUpdate", "OnFrame", "OnDraw"}
STR = r'"((?:[^"\\]|\\.)*)"'


def check(path):
    text = open(path, encoding="utf-8").read()
    found = []
    for block in text.split("\n\t\t{\n\t\t\tdata = \n")[1:]:
        m = re.search(r"\n\t\t\t\teventType = (\d+),", block)
        if not m:
            continue
        event = EVENTS.get(int(m.group(1)), "event %s" % m.group(1))
        if event in POLLED:
            continue
        code = re.findall(r"actionLua = " + STR, block) + re.findall(r"\n\t\t\t\texecute = " + STR, block)
        if not code or any("self.used" in c for c in code):
            continue
        names = re.findall(r'\n\t\t\t\tname = "([^"]+)"', block)
        found.append((event, names[0] if names else "?"))
    return found


def main(argv):
    here = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    files = argv or sorted(glob.glob(os.path.join(here, "TimelineReactions", "**", "*.lua"), recursive=True)
                           + glob.glob(os.path.join(here, "GeneralReactions", "**", "*.lua"), recursive=True))
    total = 0
    for f in files:
        found = check(f)
        if found:
            print("%s: %d" % (os.path.basename(f), len(found)))
            for event, name in found:
                print("  %-20s %s" % (event, name))
        total += len(found)
    print("event reactions without self.used: %d" % total)
    return 1 if total else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
