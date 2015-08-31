def match(command, settings):
    return (command.script.startswith('ccat ')
                       and ('source-highlight: could not find a language definition for input file' in command.stderr))

def get_new_command(command, settings):
    return 'cat '.format(command.script)

enabled_by_default = True
requires_output = True
