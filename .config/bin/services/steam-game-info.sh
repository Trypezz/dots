#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'EOF'
Usage: steam-game-info.sh [OPTIONS] <Name of the game>

Options:
  -l, --list          List all installed games (Name + App-ID)
  -e, --exact         Only exact names
  -a, --appid <id>    Search with App-ID instead of name
  -q, --quiet         Only paths
  -h, --help          This help text

Exaples:
  steam-game-info.sh persona
  steam-game-info.sh --exact "Hollow Knight"
  steam-game-info.sh --appid 1091500
  steam-game-info.sh --list | grep -i proto
EOF
}

LIST_ONLY=0
EXACT=0
QUIET=0
APPID_QUERY=""
QUERY=""

while [[ $# -gt 0 ]]; do
  case "$1" in
  -l | --list)
    LIST_ONLY=1
    shift
    ;;
  -e | --exact)
    EXACT=1
    shift
    ;;
  -q | --quiet)
    QUIET=1
    shift
    ;;
  -a | --appid)
    APPID_QUERY="${2:-}"
    shift 2
    ;;
  -h | --help)
    usage
    exit 0
    ;;
  --)
    shift
    break
    ;;
  -*)
    echo "Unknown option: $1" >&2
    usage
    exit 1
    ;;
  *)
    QUERY="$*"
    break
    ;;
  esac
done

# --- Find steam root-directories ---------------------------------------

declare -a STEAM_ROOTS=()

add_root() {
  local p="$1"
  [[ -z "$p" ]] && return
  # Get symlinks, Avoid duplicates
  if [[ -d "$p" ]]; then
    local real
    real="$(readlink -f "$p" 2>/dev/null || echo "$p")"
    local r
    for r in "${STEAM_ROOTS[@]+"${STEAM_ROOTS[@]}"}"; do
      [[ "$r" == "$real" ]] && return
    done
    STEAM_ROOTS+=("$real")
  fi
}

# Typical paths (native + Flatpak etc...)
add_root "${HOME}/.local/share/Steam"
add_root "${HOME}/.steam/steam"
add_root "${HOME}/.steam/root"
add_root "${HOME}/.steam/debian-installation"
add_root "${HOME}/.var/app/com.valvesoftware.Steam/.local/share/Steam"
add_root "${HOME}/.var/app/com.valvesoftware.Steam/data/Steam"

# Some Setups just have this Symlink ~/.steam/steam
if [[ -L "${HOME}/.steam/steam" ]]; then
  add_root "$(readlink -f "${HOME}/.steam/steam")"
fi

if [[ ${#STEAM_ROOTS[@]} -eq 0 ]]; then
  echo "No steam directory found" >&2
  echo "Expected example ~/.local/share/Steam or Flatpak-Path." >&2
  exit 1
fi

# --- Get all Library-Directories from libraryfolders.vdf ---------------------

declare -a LIBS=()

add_lib() {
  local p="$1"
  [[ -z "$p" ]] && return
  # For ntfs drives
  p="${p//\\//}" # Windows-Backslashes -> /
  if [[ -d "$p/steamapps" ]]; then
    local real
    real="$(readlink -f "$p" 2>/dev/null || echo "$p")"
    local r
    for r in "${LIBS[@]+"${LIBS[@]}"}"; do
      [[ "$r" == "$real" ]] && return
    done
    LIBS+=("$real")
  fi
}

parse_libraryfolders() {
  local vdf="$1"
  [[ -f "$vdf" ]] || return
  while IFS= read -r line; do
    if [[ "$line" =~ \"path\"[[:space:]]+\"([^\"]+)\" ]]; then
      add_lib "${BASH_REMATCH[1]}"
    elif [[ "$line" =~ ^[[:space:]]*\"[0-9]+\"[[:space:]]+\"(/[^\"]+)\" ]]; then
      add_lib "${BASH_REMATCH[1]}"
    fi
  done <"$vdf"
}

for root in "${STEAM_ROOTS[@]}"; do
  add_lib "$root"
  parse_libraryfolders "$root/steamapps/libraryfolders.vdf"
  parse_libraryfolders "$root/config/libraryfolders.vdf"
done

if [[ ${#LIBS[@]} -eq 0 ]]; then
  echo "No Steam-Library (steamapps) found" >&2
  exit 1
fi

# --- Reading ACF-Felder ----------------------------------------------------

acf_field() {
  # $1 = file, $2 = fieldname (appid|name|installdir)
  local file="$1" key="$2"
  # ACF is Text-VDF: "key"    "value"
  local val
  val="$(grep -m1 -E "^[[:space:]]*\"${key}\"" "$file" 2>/dev/null |
    sed -E 's/^[[:space:]]*"[^"]+"[[:space:]]+"//; s/"[[:space:]]*$//')"
  printf '%s' "$val"
}

# One Entry: appid|name|installdir|library_root
declare -a GAMES=()

for lib in "${LIBS[@]}"; do
  shopt -s nullglob
  for acf in "$lib"/steamapps/appmanifest_*.acf; do
    local_appid="$(acf_field "$acf" "appid")"
    local_name="$(acf_field "$acf" "name")"
    local_idir="$(acf_field "$acf" "installdir")"
    [[ -z "$local_appid" ]] && continue
    GAMES+=("${local_appid}|${local_name}|${local_idir}|${lib}")
  done
  shopt -u nullglob
done

if [[ ${#GAMES[@]} -eq 0 ]]; then
  echo "No appmanifest_*.acf files found – Maybe no game is installed" >&2
  exit 1
fi

# --- Listing --------------------------------------------------------------

if [[ "$LIST_ONLY" -eq 1 ]]; then
  printf '%-10s|   %s\n\n' "App-ID" "Name"
  printf '%s\n' "${GAMES[@]}" |
    sort -t'|' -k2,2 |
    while IFS='|' read -r appid name idir lib; do
      printf '%-10s|   %s\n' "$appid" "$name"
    done
  exit 0
fi

if [[ -z "$QUERY" && -z "$APPID_QUERY" ]]; then
  echo "Please enter name of a game or --appid <appid>" >&2
  usage
  exit 1
fi

# --- Search -----------------------------------------------------------------

declare -a HITS=()

normalize() {
  # Format input for easier search
  echo "$1" | tr '[:upper:]' '[:lower:]' | sed -E 's/[[:space:]]+/ /g; s/^ //; s/ $//'
}

if [[ -n "$APPID_QUERY" ]]; then
  for g in "${GAMES[@]}"; do
    IFS='|' read -r appid name idir lib <<<"$g"
    if [[ "$appid" == "$APPID_QUERY" ]]; then
      HITS+=("$g")
    fi
  done
else
  q_norm="$(normalize "$QUERY")"
  for g in "${GAMES[@]}"; do
    IFS='|' read -r appid name idir lib <<<"$g"
    n_norm="$(normalize "$name")"
    if [[ "$EXACT" -eq 1 ]]; then
      [[ "$n_norm" == "$q_norm" ]] && HITS+=("$g")
    else
      [[ "$n_norm" == *"$q_norm"* ]] && HITS+=("$g")
    fi
  done
fi

if [[ ${#HITS[@]} -eq 0 ]]; then
  echo "No installed game found for: ${APPID_QUERY:-$QUERY}" >&2
  echo "Tip:  $0 --list shows all installed steam games" >&2
  exit 2
fi

print_hit() {
  local appid="$1" name="$2" idir="$3" lib="$4"

  local install_path="${lib}/steamapps/common/${idir}"
  # compatdata is in the same directory as the game
  local compat="${lib}/steamapps/compatdata/${appid}"
  # Fallback: some prefixes are only in Main-Library
  if [[ ! -d "$compat" ]]; then
    for root in "${STEAM_ROOTS[@]}"; do
      if [[ -d "${root}/steamapps/compatdata/${appid}" ]]; then
        compat="${root}/steamapps/compatdata/${appid}"
        break
      fi
    done
  fi

  if [[ "$QUIET" -eq 1 ]]; then
    printf 'Name:\t\t%s\nApp-ID:\t\t%s\nCompdata:\t%s\nInstall Path:\t%s\n' "$name" "$appid" "$compat" "$install_path"
    return
  fi

  echo "Name:           $name"
  echo "App-ID:         $appid"
  echo "Installed in:"
  if [[ -d "$install_path" ]]; then
    echo "                $install_path"
  else
    echo "                $install_path  (Directory does not exist yet / Game is not fully installed yet)"
  fi
  echo "compatdata:"
  if [[ -d "$compat" ]]; then
    echo "                $compat"
    echo "pfx:            ${compat}/pfx"
    echo "drive_c:        ${compat}/pfx/drive_c"
  else
    echo "                $compat  (No prefix yet – Game needs to be started through Proton at least once)"
  fi
  echo "Steam-Library:  $lib"
}

if [[ ${#HITS[@]} -eq 1 ]]; then
  IFS='|' read -r appid name idir lib <<<"${HITS[0]}"
  print_hit "$appid" "$name" "$idir" "$lib"
  exit 0
fi

echo "Multiple Entries (${#HITS[@]}):"
echo
i=1
for g in "${HITS[@]}"; do
  IFS='|' read -r appid name idir lib <<<"$g"
  printf '  [%d]  %s  (App-ID %s)\n' "$i" "$name" "$appid"
  i=$((i + 1))
done
echo
echo "Please use --exact or --appid <id> for a more precised output"
echo
# Eventhough we print all – mostly its exactly what we want
i=1
for g in "${HITS[@]}"; do
  IFS='|' read -r appid name idir lib <<<"$g"
  echo "---------- Entry $i ----------"
  print_hit "$appid" "$name" "$idir" "$lib"
  echo
  i=$((i + 1))
done
