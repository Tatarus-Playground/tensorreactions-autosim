"""Export your own AutoSim reactions from TensorReactions profiles into this repository.

Usage (from the repository root):
    py -3 tools/export_autosim.py .
Set TR_ROOT if TensorReactions is not in the default MINION folder.

Only profile files directly inside TimelineReactions/ and GeneralReactions/ are read (subfolders are
other authors' modules), only the profiles listed in INCLUDE are exported, and inherited store
reactions are skipped. A reaction is exported when its
name or Lua mentions AutoSim, plus the Burn on/off reactions that use the same globals.
"""
import os, re, sys, json, shutil
ROOT = os.environ.get("TR_ROOT", r"C:\MINIONAPP\Bots\FFXIVMinion64\LuaMods\TensorReactions")

# ---------- tiny Lua table parser (TensorReactions save format) ----------
TOK = re.compile(r'\s*(?:(--[^\n]*)|("(?:\\.|[^"\\])*")|(\[)|(\])|(\{)|(\})|(=)|(,)|(-?\d+(?:\.\d+)?(?:[eE][-+]?\d+)?)|([A-Za-z_][A-Za-z0-9_]*))', re.S)
ESC = {'n': '\n', 't': '\t', 'r': '\r', '"': '"', '\\': '\\', "'": "'", 'a': '\a', 'b': '\b', 'f': '\f', 'v': '\v'}

def unq(s):
    s = s[1:-1]; out = []; i = 0
    while i < len(s):
        c = s[i]
        if c == '\\' and i + 1 < len(s):
            n = s[i + 1]
            if n.isdigit():
                m = re.match(r'\d{1,3}', s[i + 1:]); out.append(chr(int(m.group(0)))); i += 1 + len(m.group(0)); continue
            out.append('\n' if n == '\n' else ESC.get(n, n)); i += 2; continue
        out.append(c); i += 1
    return ''.join(out)

def tokens(src):
    pos = 0; toks = []
    while pos < len(src):
        m = TOK.match(src, pos)
        if not m or m.end() == pos:
            if src[pos:].strip() == '': break
            raise ValueError("bad token at %d: %r" % (pos, src[pos:pos + 40]))
        pos = m.end()
        if m.group(1): continue
        for gi, kind in ((2, 'str'), (3, '['), (4, ']'), (5, '{'), (6, '}'), (7, '='), (8, ','), (9, 'num'), (10, 'id')):
            if m.group(gi) is not None: toks.append((kind, m.group(gi))); break
    return toks

class LT:
    """Lua table with both keyed and array parts (keeps order)."""
    def __init__(s, kv, arr): s.kv = kv; s.arr = arr
    def get(s, k, default=None):
        for a, b in s.kv:
            if a == k: return b
        return default

class P:
    def __init__(s, toks): s.t = toks; s.i = 0
    def peek(s, k=0): return s.t[s.i + k] if s.i + k < len(s.t) else (None, None)
    def next(s): v = s.t[s.i]; s.i += 1; return v
    def value(s):
        k, v = s.next()
        if k == 'str': return unq(v)
        if k == 'num': return float(v) if ('.' in v or 'e' in v.lower()) else int(v)
        if k == 'id': return {'true': True, 'false': False, 'nil': None}[v]
        if k == '{': return s.table()
        raise ValueError((k, v))
    def table(s):
        arr = []; kv = []
        while True:
            k, v = s.peek()
            if k == '}': s.next(); break
            if k == ',': s.next(); continue
            if k == '[':
                s.next(); key = s.value(); s.next(); s.next(); kv.append((key, s.value()))
            elif k == 'id' and s.peek(1)[0] == '=':
                s.next(); s.next(); kv.append((v, s.value()))
            else:
                arr.append(s.value())
        if kv and not arr and all(isinstance(a, str) for a, _ in kv): return dict(kv)
        if not kv: return arr
        return LT(kv, arr)

def load(path):
    src = open(path, encoding='utf-8', errors='replace').read()
    i = src.index('{'); j = src.rindex('return')
    p = P(tokens(src[i:j])); p.next()
    return p.table()

# ---------- Lua serializer (same style as the source files) ----------
def lstr(s):
    return '"' + s.replace('\\', '\\\\').replace('"', '\\"').replace('\n', '\\n').replace('\r', '\\r').replace('\t', '\\t') + '"'

IDENT = re.compile(r'^[A-Za-z_]\w*$')
def ser(v, ind=1):
    pad = '\t' * ind; close = '\t' * (ind - 1)
    if isinstance(v, bool): return 'true' if v else 'false'
    if v is None: return 'nil'
    if isinstance(v, (int, float)): return repr(v)
    if isinstance(v, str): return lstr(v)
    if isinstance(v, list):
        return '\n' + close + '{\n' + ''.join(pad + ser(x, ind + 1) + ',\n' for x in v) + close + '}'
    kv = v.kv if isinstance(v, LT) else list(v.items())
    arr = v.arr if isinstance(v, LT) else []
    body = ''.join(pad + ser(x, ind + 1) + ',\n' for x in arr)
    for k, val in kv:
        ks = ('[%s]' % k) if not isinstance(k, str) else (k if IDENT.match(k) else '[%s]' % lstr(k))
        body += pad + ks + ' = ' + ser(val, ind + 1) + ',\n'
    return '\n' + close + '{\n' + body + close + '}'

# ---------- selection ----------
SKIPFILES = {"jacob's toolbox.lua"}  # other authors
# Profiles published in this repository (file names without .lua); edit to add more
INCLUDE = {"timeline": {"Tataru-Zelen", "TataruNecron"}, "general": {"blm"}}
AUTOSIM = re.compile(r'AutoSim', re.I)

def items_of(profile):
    """yield (bucket, item): timeline index buckets, or None for general profiles"""
    if isinstance(profile, LT):
        for k, v in profile.kv:
            if not isinstance(k, str) and isinstance(v, list):
                for it in v: yield k, it
        for it in profile.arr:
            if isinstance(it, list):
                for x in it: yield None, x
            elif isinstance(it, dict): yield None, it
    elif isinstance(profile, list):
        for it in profile: yield None, it

def own(it):
    return isinstance(it, dict) and not it.get("inheritedObjectUUID") and not it.get("inheritanceRoot")

def lua_of(it):
    d = it.get("data", {})
    out = [d.get("execute") or ""]
    for a in d.get("actions") or []:
        if isinstance(a, dict): out.append(a.get("data", {}).get("actionLua") or "")
    for c in d.get("conditions") or []:
        if isinstance(c, dict): out.append(c.get("data", {}).get("conditionLua") or "")
    return "\n".join(out)

def pick(profile):
    its = [(b, it) for b, it in items_of(profile) if own(it) and it.get("objectType") != "folder"]
    sel = [(b, it) for b, it in its if AUTOSIM.search(lua_of(it)) or AUTOSIM.search(it.get("data", {}).get("name", ""))]
    if sel:
        # companions: Burn on/off reactions that use globals the AutoSim reactions set
        glob = set(re.findall(r'\b(Tensor[A-Za-z0-9]+(?:Burn)?|ACR_[A-Za-z0-9_]+Burn)\b', "\n".join(lua_of(i) for _, i in sel)))
        glob -= {"TensorCore", "TensorACR"}
        ids = {id(i) for _, i in sel}
        for b, it in its:
            if id(it) in ids: continue
            l = lua_of(it)
            if glob and any(g in l for g in glob) and re.search(r'Burn|kill', l + it["data"].get("name", ""), re.I):
                sel.append((b, it)); ids.add(id(it))
    return sel

def safe(n): return re.sub(r'[\\/:*?"<>|]+', '_', n).strip().rstrip('.') or "unnamed"

def describe(it):
    d = it["data"]
    lines = ["-- " + d.get("name", "")]
    for k in ("eventType", "displayPath", "mechanicTime", "timelineIndex", "timerStartOffset", "timerEndOffset", "loop", "enabled"):
        if k in d: lines.append("-- %s: %s" % (k, d[k]))
    for c in d.get("conditions") or []:
        cd = c.get("data", {}) if isinstance(c, dict) else {}
        desc = ", ".join("%s=%s" % (k, cd[k]) for k in cd if k not in ("uuid", "version", "conditionLua") and not isinstance(cd[k], (dict, list, LT)))
        lines.append("-- condition: " + desc)
        if cd.get("conditionLua"):
            lines.append("-- condition lua:")
            lines += ["--   " + x for x in cd["conditionLua"].splitlines()]
    body = []
    if d.get("execute"): body.append("-- [execute]\n" + d["execute"])
    for a in d.get("actions") or []:
        ad = a.get("data", {}) if isinstance(a, dict) else {}
        if ad.get("actionLua"):
            body.append("-- [action] " + ad.get("name", "") + "\n" + ad["actionLua"])
        else:
            body.append("-- [action] " + ", ".join("%s=%s" % (k, ad[k]) for k in ad if k not in ("uuid", "version") and not isinstance(ad[k], (dict, list, LT))))
    return "\n".join(lines) + "\n\n" + "\n\n".join(body).rstrip() + "\n"

def export(kind, src_dir, dst_dir, summary):
    for fn in sorted(os.listdir(src_dir)):
        p = os.path.join(src_dir, fn)
        if not (fn.endswith(".lua") and os.path.isfile(p)): continue
        if fn.lower() in SKIPFILES: continue
        if INCLUDE.get(kind) and fn[:-4].strip() not in INCLUDE[kind]: continue
        try:
            prof = load(p)
        except Exception as e:
            summary.append((kind, fn, "PARSE ERROR " + str(e)[:80], 0)); continue
        sel = pick(prof)
        if not sel: continue
        od = os.path.join(dst_dir, safe(fn[:-4])); os.makedirs(od, exist_ok=True)
        folders = {}
        for b, it in items_of(prof):
            if own(it) and it.get("objectType") == "folder": folders.setdefault(b, []).append(it)
        used = set(); buckets = {}
        for b, it in sel:
            buckets.setdefault(b, []).append(it)
            fnm = safe(it["data"].get("name", "reaction"))
            while fnm.lower() in used: fnm += "_"
            used.add(fnm.lower())
            with open(os.path.join(od, fnm + ".lua"), "w", encoding="utf-8", newline="\n") as fh:
                fh.write(describe(it))
        def fold_for(b, its):
            names = set()
            for it in its:
                for part in (it["data"].get("displayPath") or "").split("/"):
                    if part: names.add(part)
            return [f for f in folders.get(b, []) if f["data"].get("name") in names]
        if isinstance(prof, LT) and any(b is not None for b in buckets):
            kv = [(b, fold_for(b, buckets[b]) + buckets[b]) for b in sorted(x for x in buckets if x is not None)]
            for k in ("timelineName", "version"):
                if prof.get(k) is not None: kv.append((k, prof.get(k)))
            kv.append(("inheritedProfiles", []))
            loose = buckets.get(None, [])
            nat = LT(kv, [fold_for(None, loose) + loose] if loose else [])
        else:
            its = [it for _, it in sel]
            nat = fold_for(None, its) + its
        with open(os.path.join(od, "_profile_subset.lua"), "w", encoding="utf-8", newline="\n") as fh:
            fh.write("local tbl = " + ser(nat, 1) + "\n\nreturn tbl\n")
        summary.append((kind, fn, prof.get("timelineName", "") if isinstance(prof, LT) else "", len(sel)))

if __name__ == "__main__":
    OUT = sys.argv[1]
    for sub in ("timeline", "general"):
        if os.path.exists(os.path.join(OUT, sub)): shutil.rmtree(os.path.join(OUT, sub))
    os.makedirs(OUT, exist_ok=True)
    S = []
    export("timeline", os.path.join(ROOT, "TimelineReactions"), os.path.join(OUT, "timeline"), S)
    export("general", os.path.join(ROOT, "GeneralReactions"), os.path.join(OUT, "general"), S)
    for s in S: print(s)
