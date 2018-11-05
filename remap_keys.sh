FROM='"HIDKeyboardModifierMappingSrc"'
TO='"HIDKeyboardModifierMappingDst"'

# key codes from https://developer.apple.com/library/archive/technotes/tn2450/_index.html#//apple_ref/doc/uid/DTS40017618-CH1-KEY_TABLE_USAGES
SECTION="0x700000064" # §/± button
ESCAPE="0x700000029"
SHIFT_LOCK="0x700000039" #caps lock

function _Map # FROM TO
{
    CMD="${CMD:+${CMD},}{${FROM}: ${1}, ${TO}: ${2}}"
}

function _MapDefaults
{
  hidutil property --set '{"UserKeyMapping":[]}'
}


_Map ${SECTION} ${ESCAPE}

hidutil property --set "{\"UserKeyMapping\":[${CMD}]}" > /dev/null
