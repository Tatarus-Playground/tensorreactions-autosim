"""Copy a TensorReactions profile file without anything inherited.

Removes:
  - inherited folder links (entries with `inheritanceRoot`)
  - overrides of inherited reactions (entries with `inheritedObjectUUID`)
  - the names in `inheritedProfiles` (the table is kept, empty)
  - timeline entries that only held removed items

Everything else is copied byte for byte, so your own reactions are untouched.

Usage: python strip_inherited.py SOURCE.lua DEST.lua
"""
import re
import sys

INHERITED_KEYS = ("inheritanceRoot", "inheritedObjectUUID")


class Table:
    def __init__(self, open_pos):
        self.open = open_pos   # index of '{'
        self.close = None      # index of matching '}'
        self.elems = []        # list of Elem


class Elem:
    def __init__(self, start):
        self.start = start     # first char of key or value
        self.key = None        # str key name, or None for positional/[n]
        self.value = None      # Table or None (scalar)
        self.end = None        # index just after trailing ',' (or after value)


def parse(text):
    """Parse the serialized table. Only "..." strings exist in these files."""
    i, n = 0, len(text)
    root = None
    stack = []  # (Table, current Elem or None)

    def skip_ws(j):
        while j < n and text[j] in " \t\r\n":
            j += 1
        return j

    def skip_string(j):
        assert text[j] == '"'
        j += 1
        while True:
            c = text[j]
            if c == "\\":
                j += 2
            elif c == '"':
                return j + 1
            else:
                j += 1

    i = text.index("{")
    root = Table(i)
    stack.append([root, None])
    i += 1
    while stack:
        i = skip_ws(i)
        tbl, cur = stack[-1]
        c = text[i]
        if c == "}":
            if cur is not None:
                cur.end = i
                tbl.elems.append(cur)
            tbl.close = i
            stack.pop()
            i += 1
            if stack:
                ptbl, pcur = stack[-1]
                pcur.value = tbl
                j = skip_ws(i)
                if j < n and text[j] == ",":
                    pcur.end = j + 1
                    ptbl.elems.append(pcur)
                    stack[-1][1] = None
                    i = j + 1
                else:
                    pcur.end = i
            continue
        if c == ",":
            cur.end = i + 1
            tbl.elems.append(cur)
            stack[-1][1] = None
            i += 1
            continue
        # start of an element
        if cur is None:
            cur = Elem(i)
            stack[-1][1] = cur
        m = re.compile(r"([A-Za-z_][A-Za-z0-9_]*)\s*=").match(text, i)
        if m and cur.key is None and cur.value is None:
            cur.key = m.group(1)
            i = m.end()
            continue
        if c == "[":
            j = i + 1
            j = skip_ws(j)
            if text[j] == '"':
                j = skip_string(j)
            else:
                while text[j] != "]":
                    j += 1
            j = text.index("]", j) + 1
            j = skip_ws(j)
            assert text[j] == "=", "bad key at %d" % i
            i = j + 1
            continue
        if c == "{":
            stack.append([Table(i), None])
            i += 1
            continue
        if c == '"':
            i = skip_string(i)
            continue
        # scalar: number / true / false / nil
        m = re.compile(r"[^\s,}]+").match(text, i)
        i = m.end()
    return root


def keys_of(tbl):
    return {e.key for e in tbl.elems if e.key}


def line_start(text, pos):
    return text.rfind("\n", 0, pos) + 1


def removal_span(text, e):
    """Whole lines of an element, plus one whitespace-only line before it."""
    s = line_start(text, e.start)
    end = text.find("\n", e.end)
    end = len(text) if end < 0 else end + 1
    prev = line_start(text, s - 1) if s > 0 else 0
    if s > 0 and text[prev:s].strip() == "":
        s = prev
    return s, end


def trailing(text, e):
    """Whitespace after an element's comma on its last line (the saver writes "}, " for some)."""
    end = text.find("\n", e.end)
    end = len(text) if end < 0 else end
    return text[e.end:end]


def collect(text, tbl, spans, depth, fixes=None):
    """Return True when every element of tbl was removed."""
    if fixes is None:
        fixes = []
    removed = 0
    last_kept = None
    for e in tbl.elems:
        v = e.value
        drop = False
        if isinstance(v, Table):
            if keys_of(v) & set(INHERITED_KEYS):
                drop = True
            elif e.key == "inheritedProfiles":
                for c in v.elems:
                    spans.append(removal_span(text, c))
            else:
                had = len(v.elems)
                inner = []
                inner_fixes = []
                if collect(text, v, inner, depth + 1, inner_fixes) and had and depth == 0:
                    drop = True      # timeline entry left empty
                else:
                    spans.extend(inner)
                    fixes.extend(inner_fixes)
        if drop:
            spans.append(removal_span(text, e))
            removed += 1
            # keep the saver's trailing-space quirk on the entry now in front
            t = trailing(text, e)
            if last_kept is not None and t and not trailing(text, last_kept):
                fixes.append((last_kept.end, t))
        else:
            last_kept = e
    return removed == len(tbl.elems)


def strip(text):
    root = parse(text)
    spans, fixes = [], []
    collect(text, root, spans, 0, fixes)
    edits = [(s, e, "") for s, e in spans] + [(p, p, t) for p, t in fixes]
    edits.sort()
    out, pos = [], 0
    for s, e, ins in edits:
        if s < pos:
            continue
        out.append(text[pos:s])
        out.append(ins)
        pos = e
    out.append(text[pos:])
    return "".join(out), len(spans)


def main():
    src, dst = sys.argv[1], sys.argv[2]
    with open(src, "r", encoding="utf-8", newline="") as f:
        text = f.read()
    result, count = strip(text)
    for k in INHERITED_KEYS:
        assert k not in result, "%s still present" % k
    with open(dst, "w", encoding="utf-8", newline="") as f:
        f.write(result)
    print("removed %d inherited item(s)" % count)


if __name__ == "__main__":
    main()
