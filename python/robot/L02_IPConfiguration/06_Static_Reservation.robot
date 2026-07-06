*** Settings ***
Resource    ../common.resource

*** Variables ***
${CLIENT_MAC}          52:54:00:12:34:56
${EXPECTED_ADDRESS}    192.168.1.200

*** Test Cases ***

L2-050 Static Reservation Exists
    ${out}=    USP Query    Device.DHCPv4.Server.Pool.1.StaticAddress.?
    Should Not Contain    ${out}    ERROR

L2-051 Reserved Address Correct
    ${out}=    USP Query    Device.DHCPv4.Server.Pool.1.StaticAddress.1.Yiaddr?
    Should Contain    ${out}    ${EXPECTED_ADDRESS}
