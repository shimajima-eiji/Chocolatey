"""
for Version3
"""
def echo(message):
  print(message)

def getPath(path = __file__):
  error_message = 'no such for path %s' % path
  try:
    from pathlib import Path
    path = Path(path)
    if path.exists():
      return path.parent if path.is_file() else path
    else:
      echo(error_message)
  except ImportError:
    from os.path import exists, dirname, isdir
    if exists(path):
      return dirname(path) if isdir(path) else path
    else:
      echo(error_message)

def ls(path = None):
  from os import getcwd, listdir
  if path == '\\':
    path = getPath()
  elif path == None:
    path = getcwd()

  echo(listdir(getPath(path)))

if __name__ == '__main__':
  def find_package(line):
    if 'package id' in line:
      return line

  def set_command(line):
    return "cinst %s\n" % line.split('"')[1]

  files = {
    'base': "%s/chocolatey.config" % getPath(),
    'result': "%s/chocolatey.bat" % getPath()
  }
  with open(files['base'], "r") as data:
    with open(files['result'], "w") as target:
      [target.write(command) for command in [set_command(line) for line in data if find_package(line)]]
  ls('\\')
