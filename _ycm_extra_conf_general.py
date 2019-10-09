# Original conf
def Settings(**kwargs):
	return {'flags': [
	'-Wall',
    '-Wextra',
    '-Werror',
    '-std=c++11',
    '-x', 'c++',
    '-isystem', '/usr/include/c++/7.4.0',
    '-isystem', '/usr/include/c++/7.4.0/x86_64-pc-linux-gnu',
    '-isystem', '/usr/include/c++/7.4.0/backward',
    '-isystem', '/usr/local/include',
    '-isystem', '/usr/include']}
