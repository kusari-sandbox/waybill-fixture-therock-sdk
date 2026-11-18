"""Census of dependency manifests under dot-directories (waybill #1610).

Usage: python3 -I -B dotdirs.py <tree> <out.json>

waybill's walkers skip every directory whose name starts with `.`. This lists
what that skip hides: every file under a dot-directory (other than `.git`),
grouped by the outermost dot-directory's name and by manifest type, where the
type is recognised by file name alone. Also counts the files under each
dot-directory name, so tool caches and virtualenvs show up for what they are.

A measuring script, not a model of a reader: a file counted here may or may
not be read by waybill once its directory is walked.
"""

import collections
import fnmatch
import json
import os
import sys

root, out_path = sys.argv[1:3]

TYPES = [
    ("pip-requirements", ["*requirements*.txt", "constraints*.txt", "requirements/*.txt"]),
    ("python-project", ["pyproject.toml", "setup.py", "setup.cfg", "Pipfile", "Pipfile.lock", "poetry.lock", "uv.lock", "pdm.lock"]),
    ("npm", ["package.json", "package-lock.json", "npm-shrinkwrap.json", "yarn.lock", "pnpm-lock.yaml", "bun.lock", "bun.lockb"]),
    ("cargo", ["Cargo.toml", "Cargo.lock"]),
    ("go", ["go.mod", "go.sum", "go.work"]),
    ("ruby", ["Gemfile", "Gemfile.lock", "*.gemspec"]),
    ("jvm", ["pom.xml", "build.gradle", "build.gradle.kts", "settings.gradle*", "gradle.lockfile", "libs.versions.toml"]),
    ("dotnet", ["*.csproj", "packages.lock.json", "Directory.Packages.props", "dotnet-tools.json", "packages.config"]),
    ("cmake", ["CMakeLists.txt", "*.cmake"]),
    ("conan-vcpkg", ["conanfile.txt", "conanfile.py", "vcpkg.json"]),
    ("conda", ["environment.yml", "environment.yaml"]),
    ("container", ["Dockerfile", "Dockerfile.*", "*.Dockerfile", "Containerfile"]),
    ("gha-workflow", []),
    ("gha-action", ["action.yml", "action.yaml"]),
]


def kind(rel):
    parts = rel.split("/")
    name = parts[-1]
    if len(parts) >= 3 and parts[-3] == ".github" and parts[-2] == "workflows" and name.endswith((".yml", ".yaml")):
        return "gha-workflow"
    for k, pats in TYPES:
        if any(fnmatch.fnmatch(name, p) or fnmatch.fnmatch("/".join(parts[-2:]), p) for p in pats):
            return k
    return None


files_under = collections.Counter()
manifests = collections.defaultdict(collections.Counter)
samples = collections.defaultdict(list)
for dirpath, dirnames, filenames in os.walk(root):
    dirnames[:] = sorted(d for d in dirnames if d != ".git")
    rel_dir = os.path.relpath(dirpath, root)
    parts = [] if rel_dir == "." else rel_dir.split(os.sep)
    dots = [p for p in parts if p.startswith(".")]
    if not dots:
        continue
    outer = dots[0]
    for fn in sorted(filenames):
        rel = "/".join(parts + [fn])
        files_under[outer] += 1
        k = kind(rel)
        if k:
            manifests[outer][k] += 1
            if len(samples[(outer, k)]) < 5:
                samples[(outer, k)].append(rel)

result = {
    "files_under_dotdir": dict(files_under),
    "manifests": {d: dict(c) for d, c in manifests.items()},
    "samples": {f"{d} {k}": v for (d, k), v in samples.items()},
}
json.dump(result, open(out_path, "w"), indent=1, sort_keys=True)

print("## Manifests under dot-directories\n")
print("| dot-directory | files under it | manifests by type |")
print("|---|---|---|")
for d, n in files_under.most_common():
    m = manifests.get(d)
    if m or n >= 50:
        print(f"| `{d}` | {n} | {', '.join(f'{k} {v}' for k, v in sorted(m.items(), key=lambda kv: -kv[1])) if m else '-'} |")
