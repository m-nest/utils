*** Settings ***
Resource    ../common.resource

*** Test Cases ***

N001 Ethernet Root
    ${out}=    USP Query    Device.Ethernet.?
    Should Not Contain    ${out}    ERROR

N002 IP Root
    ${out}=    USP Query    Device.IP.?
    Should Not Contain    ${out}    ERROR

N003 Routing Root
    ${out}=    USP Query    Device.Routing.?
    Should Not Contain    ${out}    ERROR

N004 Bridging Root
    ${out}=    USP Query    Device.Bridging.?
    Should Not Contain    ${out}    ERROR

N005 DNS Root
    ${out}=    USP Query    Device.DNS.?
    Should Not Contain    ${out}    ERROR
