pr() {
  TARGET="$1"
  if [ -z "$TARGET" ]; then
    echo "Usage: pr <target-branch>"
    return 1
  fi

  REPO_URL=$(git config --get remote.origin.url)

  # Convert SSH -> HTTPS style
  if [[ "$REPO_URL" == git@github.com:* ]]; then
    # strip leading git@github.com:
    REPO_PATH="${REPO_URL#git@github.com:}"
    # strip trailing .git
    REPO_PATH="${REPO_PATH%.git}"
    USER=$(echo "$REPO_PATH" | cut -d'/' -f1)
    REPO=$(echo "$REPO_PATH" | cut -d'/' -f2)
  else
    echo "Unsupported remote format: $REPO_URL"
    return 1
  fi

  CURRENT=$(git rev-parse --abbrev-ref HEAD)

  echo "Currently on '$CURRENT', comparing into '$TARGET'"
  echo "https://github.com/$USER/$REPO/compare/$TARGET...$CURRENT"
}

