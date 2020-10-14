import subprocess

workspace_name = '9:term'
instance_name = 'tmux_term'


def is_term_running():
    p = subprocess.run(['swaymsg', '-t', 'get_tree'],
                       capture_output=True,
                       check=True)
    return f'"app_id": "{instance_name}"' in p.stdout.decode('utf-8')


def run_term():
    subprocess.Popen(['alacritty', '--class', instance_name,
                      '-e', 'tmux', 'new-session', '-A', '-s', 'default'])


def get_focused(name):
    p = subprocess.run(['swaymsg', '-p', '-t', f'get_{name}'],
                       capture_output=True,
                       check=True)
    for line in p.stdout.decode('utf-8').strip().split('\n'):
        if not line or line[0] == ' ':
            continue
        segments = line.split(' ')
        if segments[-1] == '(focused)':
            return segments[1]


def hide_term():
    subprocess.run(['swaymsg', 'workspace', 'back_and_forth'], check=True)


def show_term():
    output = get_focused('outputs')
    subprocess.run(['swaymsg', 'workspace', workspace_name], check=True)
    subprocess.run(['swaymsg', 'move', 'workspace', 'to', output], check=True)
    subprocess.run(['swaymsg', 'workspace', workspace_name], check=True)


def main():
    if not is_term_running():
        run_term()

    focused_workspace = get_focused('workspaces')
    if focused_workspace == workspace_name:
        hide_term()
    else:
        show_term()


if __name__ == '__main__':
    main()
