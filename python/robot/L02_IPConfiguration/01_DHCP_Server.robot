*** Settings ***
Resource    ../common.resource

*** Test Cases ***

L2-001 DHCP Server Running
    ${out}=    Execute Command    ps | grep dnsmasq
    Should Contain    ${out}    dnsmasq

L2-002 DHCP Pool Exists
    ${out}=    USP Query    Device.DHCPv4.Server.Pool.?
    Should Not Contain    ${out}    ERROR

L2-003 DHCP Pool Enabled
    ${out}=    USP Query    Device.DHCPv4.Server.Pool.1.Enable?
    Should Contain    ${out}    true

L2-004 DHCP Lease Time Configured
    ${out}=    USP Query    Device.DHCPv4.Server.Pool.1.LeaseTime?
    Should Not Contain    ${out}    ERROR

L2-005 DHCP Server Interface Exists
    ${out}=    USP Query    Device.DHCPv4.Server.Pool.1.Interface?
    Should Not Contain    ${out}    ERROR
