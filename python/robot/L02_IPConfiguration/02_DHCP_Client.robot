*** Settings ***
Resource    ../common.resource

*** Test Cases ***

L2-010 WAN IPv4 Address Exists
    ${out}=    USP Query    Device.IP.Interface.?
    Should Contain    ${out}    IPv4Address

L2-011 WAN Has Default Gateway
    ${out}=    Execute Command    ip route
    Should Contain    ${out}    default

L2-012 DNS Server Configured
    ${out}=    Execute Command    cat /tmp/resolv.conf*
    Should Match Regexp    ${out}    .*nameserver.*
