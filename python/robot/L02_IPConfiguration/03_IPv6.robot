*** Settings ***
Resource    ../common.resource

*** Test Cases ***

L2-020 IPv6 Enabled
    ${out}=    USP Query    Device.IP.Interface.?
    Should Contain    ${out}    IPv6Address

L2-021 IPv6 Address Present
    ${out}=    Execute Command    ip -6 addr
    Should Match Regexp    ${out}    .*scope global.*

L2-022 IPv6 Default Route
    ${out}=    Execute Command    ip -6 route
    Should Contain    ${out}    default

L2-023 DHCPv6 Client Exists
    ${out}=    USP Query    Device.DHCPv6.Client.?
    Should Not Contain    ${out}    ERROR

L2-024 Prefix Delegation Exists
    ${out}=    USP Query    Device.DHCPv6.Client.1.PrefixDelegation.?
    Should Not Contain    ${out}    ERROR
