import json
import subprocess


def send_msg(msg_type, msg):
    p = subprocess.run(['i3-msg', '-t', msg_type, msg],
                       capture_output=True,
                       check=True)
    return json.loads(p.stdout.decode('utf-8'))


def is_term_running():

    def node_exists(node):
        if node.get('window_properties', {}).get('instance') == 'scratchpad_term':
            return True
        return any(node_exists(i) for i in node.get('nodes', []))

    tree = send_msg('get_tree', '')
    return node_exists(tree)


def run_term():
    subprocess.Popen([
        'alacritty', '--class', 'scratchpad_term',
        '-e', 'tmux', 'new-session', '-A', '-s', 'default'])


def get_focused_workspace():
    workspaces = send_msg('get_workspaces', '')
    for workspace in workspaces:
        if workspace['focused']:
            return workspace['name']


def get_focused_output(focused_workspace):
    outputs = send_msg('get_outputs', '')
    for out in outputs:
        if out['current_workspace'] == focused_workspace:
            return out['name']


def main():
    focused_workspace = get_focused_workspace()
    if focused_workspace == '9:term':
        send_msg('command', 'workspace back_and_forth')
    else:
        focused_output = get_focused_output(focused_workspace)
        if not is_term_running():
            run_term()
        send_msg('command', '[instance="scratchpad_term"] '
                            'move container to workspace "9:term"')
        send_msg('command', 'workspace "9:term"')
        send_msg('command', f'move workspace to output {focused_output}')


if __name__ == '__main__':
    main()
