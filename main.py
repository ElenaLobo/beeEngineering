# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.

import subprocess
import shlex

if __name__ == '__main__':
    #Execution results can be found in the Results folder
    command = 'robot -d Results TestCases/TC1.robot'
    subprocess.run(shlex.split(command))

# See PyCharm help at https://www.jetbrains.com/help/pycharm/
