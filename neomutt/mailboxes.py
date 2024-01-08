from pathlib import Path
import sys


def main():
    for inbox_dir in sys.argv[1:]:
        inbox_dir = Path(inbox_dir).resolve()
        print(inbox_dir, '', end='')

        for path in sorted(inbox_dir.glob('.*')):
            if not path.is_dir():
                continue

            segments = path.name.split('.')
            print(f'-label "{(len(segments) - 1) * 2 * " "}{segments[-1]}"',
                  path, '', end='')


if __name__ == '__main__':
    main()
