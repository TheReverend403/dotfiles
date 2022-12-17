#!/usr/bin/env python3
# https://gist.github.com/SidharthArya/f4d80c246793eb61be0ae928c9184406?permalink_comment_id=4405799#gistcomment-4405799

import i3ipc
import sys
def main():
    sway = i3ipc.Connection()
    for workspace in [ws for output in sway.get_tree().nodes for ws in output.nodes]:
        focus = workspace.find_focused()
        if focus is None:
            continue
        descendants = [d for d in workspace.descendants() if d.name is not None]
        focus = descendants.index(focus)
        focus = (focus + 1 if sys.argv[1] == "next" else focus - 1) % len(descendants)
        sway.command(f"[con_id={descendants[focus].id}] focus")
        sys.exit()
if __name__ == '__main__':
    main()
