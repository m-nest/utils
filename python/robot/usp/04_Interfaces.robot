*** Settings ***
Resource    common.resource

*** Test Cases ***

I001 Ethernet Interfaces
    ${out}=    USP Query    Device.Ethernet.Interface.?
    Should Not Contain    ${out}    ERROR

I002 IP Interfaces
    ${out}=    USP Query    Device.IP.Interface.?
    Should Not Contain    ${out}    ERROR

I003 Bridge Ports
    ${out}=    USP Query    Device.Bridging.Bridge.?
    Should Not Contain    ${out}    ERROR

I004 IPv4 Addresses
    ${out}=    USP Query    Device.IP.Interface.*.IPv4Address.?
    Should Not Contain    ${out}    ERROR

I005 IPv6 Addresses
    ${out}=    USP Query    Device.IP.Interface.*.IPv6Address.?
    Should Not Contain    ${out}    ERROR
