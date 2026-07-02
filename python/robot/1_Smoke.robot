*** Settings ***
Library    SSHLibrary
Library    String
Library    Collections

Suite Setup       Connect To Router
Suite Teardown    Close All Connections

*** Variables ***
${SSH_PORT}      22

*** Test Cases ***

L1-001 Gateway Is Reachable
    ${rc}=    Run And Return Rc    ping -c 3 ${RG_IP}
    Should Be Equal As Integers    ${rc}    0

L1-002 LAN Interface Exists
    ${out}=    Execute Command    ip link show ${LAN_IFACE}
    Should Contain    ${out}    ${LAN_IFACE}

L1-003 WAN Interface Exists
    ${out}=    Execute Command    ip link show ${WAN_IFACE}
    Should Contain    ${out}    ${WAN_IFACE}

L1-004 LAN Interface Is UP
    ${out}=    Execute Command    cat /sys/class/net/${LAN_IFACE}/operstate
    Should Be Equal    ${out.strip()}    up

L1-005 WAN Interface Is UP
    ${out}=    Execute Command    cat /sys/class/net/${WAN_IFACE}/operstate
    Should Be Equal    ${out.strip()}    up

L1-006 Default Route Exists
    ${out}=    Execute Command    ip route
    Should Contain    ${out}    default

L1-007 LAN MAC Address
    Run Keyword Unless    '${EXPECTED_LAN_MAC}'==''
    ...    Verify MAC
    ...    ${LAN_IFACE}
    ...    ${EXPECTED_LAN_MAC}

L1-008 WAN MAC Address
    Run Keyword Unless    '${EXPECTED_WAN_MAC}'==''
    ...    Verify MAC
    ...    ${WAN_IFACE}
    ...    ${EXPECTED_WAN_MAC}

L1-009 Ethernet Link Detected
    ${out}=    Execute Command    cat /sys/class/net/${WAN_IFACE}/carrier
    Should Be Equal    ${out.strip()}    1

L1-010 MTU Is 1500
    ${out}=    Execute Command    cat /sys/class/net/${LAN_IFACE}/mtu
    Should Be Equal    ${out.strip()}    1500

*** Keywords ***

Connect To Router
    Open Connection    ${RG_IP}    port=${SSH_PORT}
    Login    ${RG_USERNAME}    ${RG_PASSWORD}

Verify MAC
    [Arguments]    ${iface}    ${expected}
    ${mac}=    Execute Command    cat /sys/class/net/${iface}/address
    Should Be Equal As Strings
    ...    ${mac.strip().lower()}
    ...    ${expected.lower()}
