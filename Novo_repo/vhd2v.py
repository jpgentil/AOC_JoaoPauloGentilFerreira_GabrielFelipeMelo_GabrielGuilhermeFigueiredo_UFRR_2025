#!/usr/bin/env python3
import argparse
import re
import subprocess
import sys
from pathlib import Path

ENTITY_RE = re.compile(r"\bentity\s+([a-zA-Z_][a-zA-Z0-9_]*)\s+is\b", re.IGNORECASE)


def find_entities(vhd_paths):
    entities = []
    for p in vhd_paths:
        text = p.read_text(encoding="utf-8", errors="ignore")
        for m in ENTITY_RE.finditer(text):
            entities.append(m.group(1))
    return sorted(set(entities))


def run(cmd, **kwargs):
    print("+", " ".join(cmd))
    subprocess.run(cmd, check=True, **kwargs)


def main():
    ap = argparse.ArgumentParser(description="Translate VHDL to Verilog using GHDL.")
    ap.add_argument("paths", nargs="*", default=["."], help="Paths (files or dirs) to scan for .vhd")
    ap.add_argument("--outdir", default="verilog_out", help="Output directory for .v files")
    ap.add_argument("--std", default="08", help="VHDL standard for GHDL (default: 08)")
    ap.add_argument("--skip-tb", action="store_true", help="Skip entities starting with tb_")
    args = ap.parse_args()

    vhd_files = []
    for raw in args.paths:
        p = Path(raw)
        if p.is_dir():
            vhd_files.extend(sorted(p.rglob("*.vhd")))
        elif p.is_file() and p.suffix.lower() == ".vhd":
            vhd_files.append(p)
    vhd_files = sorted(set(vhd_files))

    if not vhd_files:
        print("No .vhd files found.", file=sys.stderr)
        return 1

    outdir = Path(args.outdir)
    outdir.mkdir(parents=True, exist_ok=True)

    analyze_cmd = ["ghdl", "-a", f"--std={args.std}"] + [str(p) for p in vhd_files]
    run(analyze_cmd)

    entities = find_entities(vhd_files)
    if args.skip_tb:
        entities = [e for e in entities if not e.lower().startswith("tb_")]

    if not entities:
        print("No entities found.", file=sys.stderr)
        return 1

    for ent in entities:
        out_path = outdir / f"{ent}.v"
        synth_cmd = ["ghdl", "--synth", f"--std={args.std}", "--out=verilog", ent]
        with out_path.open("w", encoding="utf-8") as f:
            run(synth_cmd, stdout=f)

    print(f"Done. Verilog files in: {outdir}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
