import subprocess


def get_password(name):
    p = subprocess.Popen(['pass', name], stdout=subprocess.PIPE)
    p.wait()
    password = p.stdout.read().strip()
    return password
