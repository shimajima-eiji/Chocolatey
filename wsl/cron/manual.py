import subprocess
from subprocess import PIPE

with open('./cron') as f:
  lines = [" ".join( line.split()[5:]) for line in f.readlines() if len(line.split()) > 5]
  string="\nsleep 10\n".join(lines)
  print(string)

  proc = subprocess.run(string, shell=True, stdout=PIPE, stderr=PIPE, text=True)
  print('COMPLETE: {}'.format(proc.stdout))
