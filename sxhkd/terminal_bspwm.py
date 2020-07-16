import subprocess


desktop_name = 'term'
instance_name = 'tmux_term'


def is_term_running():
    p = subprocess.run(['xdo', 'id', '-n', instance_name])
    return p.returncode == 0


def run_term():
    subprocess.Popen(['alacritty', '--class', instance_name,
                      '-e', 'tmux', 'new-session', '-A', '-s', 'default'])


def get_focused_desktop():
    p = subprocess.run(['bspc', 'query', '-D', '--names', '-d', 'focused'],
                       capture_output=True,
                       check=True)
    return p.stdout.decode('utf-8').strip()


def hide_term():
    subprocess.run(['bspc', 'desktop', '-f', 'last.local'], check=True)


def show_term():
    subprocess.run(['bspc', 'desktop', 'term', '-m', 'focused'])
    subprocess.run(['bspc', 'desktop', '-f', 'term'], check=True)


def main():
    if not is_term_running():
        run_term()

    focused_desktop = get_focused_desktop()
    if focused_desktop == desktop_name:
        hide_term()
    else:
        show_term()


if __name__ == '__main__':
    main()
