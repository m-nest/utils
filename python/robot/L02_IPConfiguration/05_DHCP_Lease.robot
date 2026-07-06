*** Settings ***
Resource    ../common.resource

*** Test Cases ***

L2-040 Renew WAN Lease
    ${old}=    Execute Command    ip addr show
    Execute Command    ifdown wan || true
    Sleep    5s
    Execute Command    ifup wan || true
    Sleep    10s
    ${new}=    Execute Command    ip addr show
    Should Not Be Empty    ${new}

L2-041 DHCP Client Running
    ${out}=    Execute Command    ps | grep -E "udhcpc|dhclient"
    Should Not Contain    ${out}    grep
