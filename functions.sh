function h() {
  cat << EOF

COMMAND  |  DESCRIPTION
         |
cal      |  displays a calendar
EOF
}

function hcal() {
  cat << EOF

COMMAND
     cal

DESCRIPTION
     displays a calendar

EXAMPLES
     $ cal 2021
     $ cal nov 2021
     $ cal -3
EOF
}
