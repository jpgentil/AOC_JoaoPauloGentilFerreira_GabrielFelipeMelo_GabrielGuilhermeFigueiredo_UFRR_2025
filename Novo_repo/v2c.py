#!/usr/bin/env python3
import argparse
import re
import shlex
import subprocess
import sys
from pathlib import Path

MODULE_RE = re.compile(r"\bmodule\s+([a-zA-Z_][a-zA-Z0-9_]*)\b")


def find_modules(v_paths):
    modules = []
    for p in v_paths:
        text = p.read_text(encoding="utf-8", errors="ignore")
        modules.extend(MODULE_RE.findall(text))
    return sorted(set(modules))


def run(cmd):
    print("+", " ".join(cmd))
    subprocess.run(cmd, check=True)


def render_cmd(template, values):
    cmd = template
    for key, value in values.items():
        cmd = cmd.replace("{" + key + "}", value)
    return cmd


def main():
    ap = argparse.ArgumentParser(description="Translate Verilog to C using a v2c-compatible tool.")
    ap.add_argument("paths", nargs="*", default=["verilog_out"], help="Paths (files or dirs) to scan for .v")
    ap.add_argument("--outdir", default="c_out", help="Output directory for .c files")
    ap.add_argument(
        "--cmd",
        default="v2c {in} -o {out}",
        help="Command template with {in}, {out}, and optional {top}",
    )
    ap.add_argument("--by-module", action="store_true", help="Emit one C file per module")
    args = ap.parse_args()

    v_files = []
    for raw in args.paths:
        p = Path(raw)
        if p.is_dir():
            v_files.extend(sorted(p.rglob("*.v")))
        elif p.is_file() and p.suffix.lower() == ".v":
            v_files.append(p)
    v_files = sorted(set(v_files))

    if not v_files:
        print("No .v files found.", file=sys.stderr)
        return 1

    if "{in}" not in args.cmd or "{out}" not in args.cmd:
        print("Command template must include {in} and {out}.", file=sys.stderr)
        return 1

    outdir = Path(args.outdir)
    outdir.mkdir(parents=True, exist_ok=True)

    if args.by_module:
        modules = find_modules(v_files)
        if not modules:
            print("No modules found.", file=sys.stderr)
            return 1
        if "{top}" not in args.cmd:
            print("--by-module requires {top} in --cmd.", file=sys.stderr)
            return 1
        for mod in modules:
            out_path = outdir / f"{mod}.c"
            cmd_str = render_cmd(
                args.cmd,
                {"in": " ".join(map(str, v_files)), "out": str(out_path), "top": mod},
            )
            run(shlex.split(cmd_str))
    else:
        for vf in v_files:
            out_path = outdir / f"{vf.stem}.c"
            cmd_str = render_cmd(
                args.cmd,
                {"in": str(vf), "out": str(out_path), "top": vf.stem},
            )
            run(shlex.split(cmd_str))

    print(f"Done. C files in: {outdir}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
