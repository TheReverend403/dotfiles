# -*- coding: utf-8 -*-

SCRIPT_NAME = "markup"
SCRIPT_AUTHOR = "on-three"
SCRIPT_VERSION = "0.0.1"
SCRIPT_LICENSE = "GPL"
SCRIPT_DESC = "use color and other markup in my IRC posts."
 
# make sure we're run under weechat.
import_ok = True
try:
  import weechat
except ImportError:
  print "This script must be run under WeeChat."
  print "Get WeeChat now at: http://www.weechat.org/"
  import_ok = False

import re
import string

colors = {
  u'white': u'00',
  u'black': u'01',
  u'darkblue': u'02',
  u'green': u'03',
  u'red': u'04',
  u'brown': u'05',
  u'purple': u'06',
  u'olive': u'07',
  u'yellow': u'08',
  u'lightgreen': u'09',
  u'teal': u'10',
  u'cyan': u'11',
  u'blue': u'12',
  u'magenta': u'13',
  u'darkgray': u'14',
  u'gray': u'15',
}

styles = {
  u'bold' :  u'\u0002',
  u'normal' : u'\u000f',
  u'underline' : u'\u001f',
  u'italic' : u'\u0009',
  u'strikethrough' : u'\u0013',
  u'reverse' : u'\u0016',
}

decorators = {
  u'note' : u'♫',#♬,♪,♩
  u'copyright' : u'©',
  u'trademark' : u'™',
  u'section' : u'§',
  u'yen' : u'¥',
  u'pound' : u'£',
  u'registered' : u'®',
  u'quarter' : u'¼',
  u'half' : u'½',
  u'threequarters' : u'¾',
  u'times' : u'×',
  u'divided' : u'÷',
  u'cross' : u'†',
  u'doubleexclaimation' : u'‼',
  u'starofdavid' : u'✡',
  u'heart' : u'❤',
  u'arrow' : u'➔',
  u'sun' : u'☀',
  u'umbrella' : u'☂',
  u'radioactive' : u'☢',
  u'euro' : u'€',
  u'telephone' : u'☎',
  u'flag' : u'⚑',
  u'cut' : u'✂',

}

def markup():
  '''Iterator to cycle through markup keys
  This supports autocompletion
  '''
  for s in styles.keys():
    yield u'[{s}]'.format(s=s)
  for c in colors.keys():
    yield u'[{c}]'.format(c=c)
  for d in decorators.keys():
    yield u'[{d}]'.format(d=d)

def markup2code(m):
  ml = m.lower()
  if ml in styles:
    return styles[ml]
  elif ml in colors:
    return u'\u0003{0}'.format(colors[ml])
  elif ml in decorators:
    return decorators[ml]
  else:
    return m

def to_color(c):
  cl = c.lower()
  if cl in colors:
    return colors[cl]
  else:
    #default to original
    return c

#have to precompile these regexes 'cause i want them case insensitive
SINGLE_MARKUP_RE = re.compile(ur'\[(?P<markup>\w+)\]', re.I|re.UNICODE)
DOUBLE_MARKUP_RE = re.compile(ur'\[(?P<foreground>\w+) (?P<background>\w+)\]', re.I|re.UNICODE)

# Functions
def process_markup(data, msgtype, servername, args):
  '''filter outgoing messages before 512 line parsing
  so the results are visible locally.
  cmd results are of the form: PRIVMSG #bariety :this is a message [h]with markup[n]
  or<MESSAGE TYPE> <channel> :<msg>
  So i'll split it by colon for now.
  '''
  args = args.decode('utf-8')
  header,blurb = string.split(args, u':', maxsplit=1)

  #first let's add [green] before the FIRST '>' that occurs, no matter where
  blurb = re.sub(ur'^>', u'[green]>', blurb)
  
  blurb = re.sub(ur'\[(?P<markup>\w+)\]', lambda match: u'{0}'.format(markup2code(match.group(1))), blurb)
  blurb = re.sub(ur'\[(?P<foreground>\w+) (?P<background>\w+)\]', lambda match: u"\u0003{0},{1}".format(to_color(match.group(1)),to_color(match.group(2))), blurb)
  args = header  + ':' + blurb
  return args

def markup_autocomplete(data, buffer, command):
  str_input = weechat.buffer_get_string(weechat.current_buffer(), "input")
  if command == u"/input complete_next":# and str_input == '':
    try:
      last_pos = str_input.rindex('[')#fails if not found.
      last = str_input[last_pos:]
      first = str_input[:last_pos]
      for m in markup():
        if m.startswith(last) and m != last and last != "":
          weechat.command(buffer, '/input delete_line')
          weechat.command(buffer, "/input insert "+ first + m)
          break
    except ValueError:
      pass
  return weechat.WEECHAT_RC_OK

 
if __name__ == "__main__":
  if import_ok and weechat.register(SCRIPT_NAME, SCRIPT_AUTHOR, SCRIPT_VERSION, SCRIPT_LICENSE, SCRIPT_DESC, "", ""):
    weechat.hook_modifier("irc_out1_privmsg", "process_markup", "")
    weechat.hook_modifier("irc_out1_topic", "process_markup", "")
    #attempt to autocomplete markup text in input area
    weechat.hook_command_run('/input complete*', 'markup_autocomplete', '')

